import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/commentButton.dart';
import 'package:gokceada/product/commentScreen.dart';
import 'package:gokceada/product/likeButton.dart';
import 'package:permission_handler/permission_handler.dart';

import '../product/indicatorWidget.dart';
import '../product/likeCountWidget.dart';
import '../utils/storage.dart';

class UsersConsole extends StatefulWidget {
  const UsersConsole({super.key});

  @override
  UsersConsoleState createState() => UsersConsoleState();
}

class UsersConsoleState extends State<UsersConsole> {
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
    getUsersImages();
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
      debugPrint('Hata oluştu: $e');
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
      debugPrint('Hata oluştu: $e');
    }
    return 0;
  }

  /*Future<void> toggleLike(String userUid, bool currentLikeStatus) async {
    DocumentReference postRef =
    FirebaseFirestore.instance.collection('images').doc(userUid);

    if (currentUser != null) {
      await postRef.update({
        'likes': currentLikeStatus
            ? FieldValue.arrayRemove([currentUser!.email])
            : FieldValue.arrayUnion([currentUser!.email])
      });
    }
  }*/
  Future<void> toggleLike(String userUid, bool currentLikeStatus) async {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('images').doc(userUid);

    if (currentUser != null) {
      await postRef.update({
        'likes': currentLikeStatus
            ? FieldValue.arrayRemove([currentUser!.email])
            : FieldValue.arrayUnion([currentUser!.email])
      });
    }
  }

  Future<void> getUsersImages() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      firebase_storage.ListResult result = await storage.listFiles('');

      List<String> userUids = result.prefixes.map((ref) => ref.name).toList();

      for (String uid in userUids) {
        firebase_storage.ListResult userResult = await storage.listFiles(uid);
        List<firebase_storage.Reference> images = userResult.items;
        imageMap[uid] = images;
      }
    } catch (e) {
      debugPrint('Error fetching images: $e');
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> getUsername() async {
    return await storage
        .getUsernameFromUid(FirebaseAuth.instance.currentUser!.uid);
  }

  //add a comment
  void addComment(String commentText, String userUid) async {
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    String? user = await storage.getUsernameFromUid(currentUserUid);

    FirebaseFirestore.instance
        .collection('images')
        .doc(userUid)
        .collection('comments')
        .add({
      'commentBy': user,
      'commentByUid': currentUserUid, // Kullanıcı UID'si ekleniyor
      'commentText': commentText,
      'commentTime': Timestamp.now(),
    });
    setState(() {});
  }

  void deleteComment(String userUid, String commentId) async {
    try {
      // Yorumun bulunduğu koleksiyona erişim
      await FirebaseFirestore.instance
          .collection('images')
          .doc(userUid)
          .collection('comments')
          .doc(commentId)
          .delete();
      debugPrint("Yorum başarıyla silindi.");
    } catch (e) {
      debugPrint("Yorum silinirken hata oluştu: $e");
    }
  }

  //show a dialog box for adding comment
  void showCommentDialog(String userUid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('yorumEkle'.tr()),
              content: TextField(
                controller: _commentTextController,
                decoration: InputDecoration(hintText: 'birYorumYaz'.tr()),
              ),
              actions: [
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commentTextController.clear();
                    },
                    child: Text('cancel'.tr())),
                //post button
                TextButton(
                    onPressed: () {
                      addComment(_commentTextController.text, userUid);
                      Navigator.pop(context);
                      _commentTextController.clear();
                    },
                    child: Text('post'.tr())),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

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
          title: Text('sizinGozunuzdenAda'.tr(),
              style: TextFonts.instance.middleTitle),
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
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1,
                                color: ColorConstants.instance.titleColor),
                          ),
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
                                        height: 30,
                                        margin: const EdgeInsets.all(8),
                                        child: Text(snapshot.data ?? '',
                                            style:
                                                TextFonts.instance.middleTitle),
                                      );
                                    } else {
                                      return Container(
                                        height: 30,
                                        margin: const EdgeInsets.all(8),
                                        child: Text('Google Kullanıcısı',
                                            style:
                                                TextFonts.instance.middleTitle),
                                      );
                                    }
                                  } else {
                                    return Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(8),
                                      child: Text('kullaniciYukleniyor'.tr(),
                                          style:
                                              TextFonts.instance.middleTitle),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder<String>(
                                future: storage.downloadURL(
                                    images.first.name, userUid),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Hata: ${snapshot.error}'),
                                      );
                                    } else {
                                      final imageUrl = snapshot.data!;
                                      return FutureBuilder<Size>(
                                        future: storage.getImageSize(imageUrl),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Size> sizeSnapshot) {
                                          if (sizeSnapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (sizeSnapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Boyut alınamadı: ${sizeSnapshot.error}'),
                                              );
                                            } else {
                                              final imageSize =
                                                  sizeSnapshot.data!;
                                              final aspectRatio =
                                                  imageSize.width /
                                                      imageSize.height;
                                              final height =
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      aspectRatio;

                                              return Container(
                                                width: double.infinity,
                                                height: height,
                                                child: PageView.builder(
                                                  itemCount: images.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int pageIndex) {
                                                    final imageRef =
                                                        images[pageIndex];
                                                    return FutureBuilder<
                                                        String>(
                                                      future:
                                                          storage.downloadURL(
                                                              imageRef.name,
                                                              userUid),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                              child: Text(
                                                                  'Hata: ${snapshot.error}'),
                                                            );
                                                          } else {
                                                            final imageUrl =
                                                                snapshot.data!;
                                                            return Image
                                                                .network(
                                                              imageUrl,
                                                              fit: BoxFit
                                                                  .contain,
                                                            );
                                                          }
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  ColorConstants
                                                                      .instance
                                                                      .titleColor,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
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
                                    }
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            ColorConstants.instance.titleColor,
                                      ),
                                    );
                                  }
                                },
                              ),
                              Center(
                                child: Indicator(
                                    list: images, controller: controller),
                              ),
                              SizedBox(
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                return Text(
                                                    'Hata: ${snapshot.error}');
                                              } else {
                                                bool isLiked = false;
                                                if (snapshot.data != null) {
                                                  List<String> likes =
                                                      List<String>.from(snapshot
                                                              .data!
                                                              .get('likes') ??
                                                          []);
                                                  isLiked = likes.contains(
                                                      currentUser?.email);
                                                }
                                                return Row(children: [
                                                  LikeButton(
                                                    initialLiked: isLiked,
                                                    onTap:
                                                        (currentLikeStatus) async {
                                                      await toggleLike(userUid,
                                                          currentLikeStatus);
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: CommentButton(
                                                        onTap:
                                                            currentUser != null
                                                                ? () {
                                                                    showCommentDialog(
                                                                        userUid);
                                                                  }
                                                                : () {}),
                                                  ),
                                                ]);
                                              }
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          LikeCountWidget(
                                              userUid: userUid,
                                              currentUser: currentUser),
                                        ],
                                      ),
                                    ),
                                    //comments under the post
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 3,
                                          bottom: 5),
                                      child: FutureBuilder<int>(
                                        future: fetchCommentsCount(userUid),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Container();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Hata: ${snapshot.error}');
                                          } else {
                                            return InkWell(
                                              child: Text(
                                                  '${snapshot.data.toString()} ${'yorumunTumunuGoster'.tr()}',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              onTap: () {
                                                //addDocument();
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SizedBox(
                                                          height: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height) *
                                                              0.7,
                                                          child: CommentsScreen(
                                                              userUid:
                                                                  userUid));
                                                    });
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ) //yorumun tümünü göster
                                  ],
                                ),
                              ),
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
                                  content:
                                      Text('kullaniciGirisiYapilmadi'.tr()),
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
                        var status = await Permission.photos.status;

                        if (!status.isGranted) {
                          status = await Permission.photos.request();
                        }

                        if (status.isGranted) {
                          final results = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.image,
                          );

                          if (results != null) {
                            final path = results.files.single.path;
                            final fileName = results.files.single.name;

                            await storage.uploadFile(
                              path!,
                              fileName,
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                            getUsersImages();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('dosyaBasariylaYuklendi'.tr()),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('resimSecilmedi'.tr()),
                              ),
                            );
                          }
                        } else if (status.isPermanentlyDenied) {
                          openAppSettings();
                        } else {
                          showAlertDialog(context);
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

showAlertDialog(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('permissionDenied'.tr()),
        content: Text('permissionDeniedMessage'.tr()),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel'.tr()),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: Text('permissionDeniedSettings'.tr()),
          ),
        ],
      ),
    );
