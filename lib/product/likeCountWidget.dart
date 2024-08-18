import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeCountWidget extends StatelessWidget {
  final String userUid;
  final User? currentUser;

  LikeCountWidget({required this.userUid, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('images').doc(userUid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final likes = List<String>.from(data['likes'] ?? []);
          final likeCount = likes.length;

          return
              Text(
                '$likeCount kişi beğendi',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              );
        } else {
          return const Text('Beğeni bilgisi bulunamadı');
        }
      },
    );
  }
}
