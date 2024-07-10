import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helper/helperMethods.dart';

class CommentsScreen extends StatefulWidget {
  final String userUid;

  const CommentsScreen({super.key, required this.userUid});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  Future<void> deleteComment(String userUid, String commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('images')
          .doc(userUid)
          .collection('comments')
          .doc(commentId)
          .delete();

      print("Yorum başarıyla silindi.");
    } catch (e) {
      print("Yorum silinirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yorumlar'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('images')
            .doc(widget.userUid)
            .collection('comments')
            .orderBy('commentTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var comments = snapshot.data!.docs;

          User? currentUser = FirebaseAuth.instance.currentUser;

          String currentUserUid;
          currentUser == null ? currentUserUid = '0' : currentUserUid = currentUser.uid;

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index];
              var commentData = comment.data() as Map<String, dynamic>;
              var commentText = commentData['commentText'];
              var commentBy = commentData['commentBy'];
              var commentByUid = commentData['commentByUid'];
              var commentTime = formatDate(commentData['commentTime']);
              var commentId = comment.id;

              return ListTile(
                title: Text(commentText),
                subtitle: Row(
                  children: [
                    Text(
                      commentBy,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text(
                      ' • ',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text(
                      commentTime,
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
                trailing: commentByUid == currentUserUid
                    ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteComment(widget.userUid, commentId);
                  },
                )
                    : null, // Sadece kendi yorumları için silme butonu
              );
            },
          );
        },
      ),
    );
  }
}
