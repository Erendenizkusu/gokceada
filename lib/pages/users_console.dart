import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/helper/helperMethods.dart';
import 'package:gokceada/product/comment.dart';
import 'package:gokceada/product/commentButton.dart';
import 'package:gokceada/product/hotelListCard.dart';
import 'package:gokceada/product/likeButton.dart';

import '../utils/storage.dart';

class UsersConsole extends StatefulWidget {
  const UsersConsole({Key? key}) : super(key: key);

  @override
  _UsersConsoleState createState() => _UsersConsoleState();
}

class _UsersConsoleState extends State<UsersConsole> {
  final Storage storage = Storage();
  Map<String, List<firebase_storage.Reference>> imageMap = {};
  bool isLoading = true;
  final _commentTextController = TextEditingController();
  Map<String, int> commentCounts = {};
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  late final List<String> likes;

  @override
  void initState() {
    super.initState();
    getUsersImages(); // Kullanıcıların resimlerini al
    likes = List<String>.empty(growable: true);
    if (currentUser != null) {
      isLiked = likes.contains(currentUser!.email);
    } else {
      isLiked = false;
    }
  }

  Future<int> fetchCommentsCount(String documentId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('images')
          .doc(documentId)
          .collection('comments')
          .get();

      return snapshot.size;
    } catch (e) {
      print('Hata oluştu: $e');
      return 0; // Hata durumunda veya belge bulunamadığında 0 döndür
    }
  }

  String extractUsernameFromEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    } else {
      return email;
    }
  }

  Future<String?> getRandomLikeEmail(String userUid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('images')
          .doc(userUid)
          .get();

      if (snapshot.exists) {
        List<String> likes = List<String>.from(snapshot.get('likes'));

        if (likes.isEmpty) {
          return null;
        }

        if (likes.contains(currentUser?.email)) {
          likes.remove(currentUser?.email);

          int randomIndex = Random().nextInt(likes.length);

          String randomLikeEmail = likes[randomIndex];
          return extractUsernameFromEmail(randomLikeEmail);
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<int> fetchLikeCount(String userUid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('images')
          .doc(userUid)
          .get();
      if (snapshot.exists) {
        List<String> likes = List<String>.from(snapshot.get('likes'));
        return likes.length;
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
    return 0;
  }

  Future<void> toggleLike(String userUid) async {
    DocumentReference postRef =
    FirebaseFirestore.instance.collection('images').doc(userUid);

    if (currentUser != null) {
      await postRef.update({
        'likes': isLiked
            ? FieldValue.arrayRemove([currentUser!.email])
            : FieldValue.arrayUnion([currentUser!.email])
      }).then((_) {
        setState(() {
          isLiked = !isLiked;
        });
      });
    }
  }

  Future<void> getUsersImages() async {
    setState(() {
      isLoading = true;
    });

    firebase_storage.ListResult result = await storage.listFiles('');

    List<String> userUids = result.prefixes.map((ref) => ref.name).toList();

    for (String uid in userUids) {
      firebase_storage.ListResult userResult = await storage.listFiles(uid);
      List<firebase_storage.Reference> images = userResult.items;
      imageMap[uid] = images;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<String?> getUsername() async {
    return await storage
        .getUsernameFromUid(FirebaseAuth.instance.currentUser!.uid);
  }

  //add a comment
  void addComment(String commentText, String userUid) async {
    String name = FirebaseAuth.instance.currentUser!.uid;
    String? user = await storage.getUsernameFromUid(name);

    FirebaseFirestore.instance
        .collection('images')
        .doc(userUid)
        .collection('comments')
        .add({
      'commentBy': user,
      'commentText': commentText,
      'commentTime': Timestamp.now(),
    });
    setState(() {
    });
  }

  //show a dialog box for adding comment
  void showCommentDialog(String userUid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add Comment'),
              content: TextField(
                controller: _commentTextController,
                decoration:
                    const InputDecoration(hintText: 'Write a comment..'),
              ),
              actions: [
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commentTextController.clear();
                    },
                    child: const Text('Cancel')),
                //post button
                TextButton(
                    onPressed: () {
                      addComment(_commentTextController.text, userUid);
                      Navigator.pop(context);
                      _commentTextController.clear();
                    },
                    child: const Text('Post')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final _controller = PageController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ColorConstants.instance.titleColor,
            ),
          ),
          title: Text(AppLocalizations.of(context).sizinGozunuzdenAda,
              style: TextFonts.instance.appBarTitleColor),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.instance.titleColor,
                ),
              )
            : ListView.builder(
                itemCount: imageMap.length,
                itemBuilder: (BuildContext context, int index) {
                  String userUid = imageMap.keys.elementAt(index);
                  List<firebase_storage.Reference> images = imageMap[userUid]!;

                  return images.isEmpty
                      ? Container()
                      : Container(
                          height: 500,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: ColorConstants.instance.titleColor)),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String?>(
                                future: storage.getUsernameFromUid(userUid),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      return Container(
                                          margin: const EdgeInsets.all(8),
                                          child: Text(snapshot.data ?? '',
                                              style: TextFonts
                                                  .instance.middleTitle));
                                    } else {
                                      return Container(
                                          margin: const EdgeInsets.all(8),
                                          child: Text('Google Kullanıcısı',
                                              style: TextFonts
                                                  .instance.middleTitle));
                                    }
                                  } else {
                                    return Container(
                                        margin: const EdgeInsets.all(8),
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .kullaniciYukeliyor,
                                            style: TextFonts
                                                .instance.middleTitle));
                                  }
                                },
                              ),
                              Expanded(
                                child: PageView.builder(
                                  controller: _controller,
                                  itemCount: images.length,
                                  itemBuilder:
                                      (BuildContext context, int pageIndex) {
                                    final imageRef = images[pageIndex];
                                    return FutureBuilder<String>(
                                      future: storage.downloadURL(
                                          imageRef.name, userUid),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Hata: ${snapshot.error}'),
                                            );
                                          } else {
                                            return Image.network(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: ColorConstants
                                                  .instance.titleColor,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              Center(
                                child: Indicator(
                                    list: images, controller: _controller),
                              ),

                              Row(children: [
                                Column(children: [
                                  FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('images')
                                        .doc(userUid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      } else if (snapshot.hasError) {
                                        return Text('Hata: ${snapshot.error}');
                                      } else {
                                        bool isLiked = false;

                                        if (currentUser != null &&
                                            snapshot.data!.exists) {
                                          List<String> likes =
                                              List<String>.from(
                                                  snapshot.data!.get('likes'));
                                          isLiked = likes
                                              .contains(currentUser!.email);
                                        }

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: LikeButton(
                                            isLiked: isLiked,
                                            onTap: () async {
                                              await toggleLike(userUid);
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ]),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: CommentButton(onTap: () {
                                        showCommentDialog(userUid);
                                      }),
                                    ),
                                  ],
                                )
                              ]),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 16, right: 10, bottom: 0),
                                child: FutureBuilder<int>(
                                  future: fetchLikeCount(userUid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      return Text('Hata: ${snapshot.error}');
                                    } else {
                                      int? likeCount = snapshot.data!;

                                      return FutureBuilder<String?>(
                                        future: getRandomLikeEmail(userUid),
                                        builder: (context, emailSnapshot) {
                                          if (emailSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Container();
                                          } else if (emailSnapshot.hasError) {
                                            return Text(
                                                'Hata: ${emailSnapshot.error}');
                                          } else {
                                            String? username =
                                                emailSnapshot.data;

                                            if (username != null) {
                                              // Kullanıcı adı mevcutsa işlemleri gerçekleştir
                                              return Text(
                                                '$username ve ${(likeCount - 1).toString()} kişi beğendi',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                  '${likeCount.toString()} kişi beğendi',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ));
                                            }
                                          }
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              //comments under the post
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 5, bottom: 5),
                                child: FutureBuilder<int>(
                                  future: fetchCommentsCount(userUid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      return Text('Hata: ${snapshot.error}');
                                    } else {
                                      return InkWell(
                                        child: Text(
                                            '${snapshot.data.toString()} yorumun tümünü göster',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400)),
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height:
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height) *
                                                          0.7,
                                                  child: StreamBuilder<
                                                      QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('images')
                                                        .doc(userUid)
                                                        .collection('comments')
                                                        .orderBy('commentTime',
                                                            descending: true)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      } else {
                                                        int userCommentCount =
                                                            snapshot.data!.docs
                                                                .length;
                                                        commentCounts[userUid] =
                                                            userCommentCount;
                                                        print(
                                                            'Comment data: ${snapshot.data!.docs}');

                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30))),
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10,
                                                                  bottom: 15),
                                                          height: 100,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: snapshot
                                                                .data!.docs
                                                                .map((doc) {
                                                              //get the comment
                                                              final commentData =
                                                                  doc.data() as Map<
                                                                      String,
                                                                      dynamic>;

                                                              //return the comment
                                                              return Comment(
                                                                  text: commentData[
                                                                      'commentText'],
                                                                  user: commentData[
                                                                      'commentBy'],
                                                                  time: formatDate(
                                                                      commentData[
                                                                          'commentTime']));
                                                            }).toList(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                );
                                              });
                                        },
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                },
              ),
        floatingActionButton: FirebaseAuth.instance.currentUser != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    FloatingActionButton(
                      heroTag: '1',
                      backgroundColor: ColorConstants.instance.titleColor,
                      onPressed: FirebaseAuth.instance.currentUser != null
                          ? () async {
                              await storage.deleteLastImage(context);
                              getUsersImages();
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)
                                      .kullaniciGirisiYapilmadi),
                                ),
                              );
                            },
                      child: const Icon(Icons.delete_forever_rounded,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    FloatingActionButton(
                      backgroundColor: ColorConstants.instance.activatedButton,
                      onPressed: () async {
                        // Dosya seçme işlemini gerçekleştir
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg'],
                        );

                        if (results != null) {
                          final path = results.files.single.path;
                          final fileName = results.files.single.name;

                          // Seçilen dosyanın işlenmesi ve yüklenmesi gibi işlemleri yapabilirsiniz
                          await storage.uploadFile(
                            path!,
                            fileName,
                            FirebaseAuth.instance.currentUser!.uid,
                          );
                          getUsersImages(); // Resimleri yeniden almak için getUsersImages() metodunu çağır

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .dosyaBasariylaYuklendi),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  AppLocalizations.of(context).resimSecilmedi),
                            ),
                          );
                        }
                      },
                      child: const Icon(Icons.upload, color: Colors.white),
                    ),
                  ])
            : FloatingActionButton(
                heroTag: '1',
                backgroundColor: ColorConstants.instance.titleColor,
                onPressed: () {
                  // Kullanıcı oturum açmamış, giriş sayfasına yönlendir
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Icon(Icons.login, color: Colors.white),
              ));
  }
}
