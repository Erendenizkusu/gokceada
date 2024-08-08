import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName, String userId) async {
    File file = File(filePath);

    try {
      await storage.ref('users/$userId/$fileName').putFile(file);

      DocumentReference newDocumentRef = FirebaseFirestore.instance.collection('images').doc(userId);

      await newDocumentRef.set({
        'likes': <String>[],
      });

      print('Yeni resim başarıyla eklendi ve döküman oluşturuldu: ${newDocumentRef.id}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<firebase_storage.ListResult> listFiles(String userId) async {
    return await storage.ref('users/$userId').listAll();
  }

  Future<String> downloadURL(String imageName, String userId) async {
    String downloadURL = await storage.ref('users/$userId/$imageName').getDownloadURL();
    return downloadURL;
  }

  Future<String?> getUsernameFromUid(String uid) async {
    try {
      if (kDebugMode) {
        print('Fetching username for UID: $uid');
      }

      final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String? username = userDoc.get('username') as String?;
        if (kDebugMode) {
          print('Username found: $username');
        }
        return username;
      } else {
        if (kDebugMode) {
          print('User not found for UID: $uid');
        }
        return null; // Kullanıcı belgesi bulunamadı
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting username from UID: $e');
      }
      return null;
    }
  }


  Future<void> deleteDocumentWithSubcollections(String userUid) async {
    // Reference to the document
    final docRef = FirebaseFirestore.instance.collection('images').doc(userUid);

    // Get all subcollections
    final subcollections = await docRef.collection('comments').get();

    // Delete all documents in the subcollection
    for (var subDoc in subcollections.docs) {
      await docRef.collection('comments').doc(subDoc.id).delete();
    }

    // Now delete the main document
    await docRef.delete();
  }

  Future<void> deleteLastImage(BuildContext context) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final storage = FirebaseStorage.instance;
      final reference = storage.ref('users/$userUid');
      final result = await reference.listAll();

      if (result.items.isNotEmpty && result.items.length != 1) {
        final lastImage = result.items.last;
        await lastImage.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('resimSilindi'.tr()),
          ),
        );
      } else if(result.items.length == 1) {
        final lastImage = result.items.last;
        await lastImage.delete();
        await deleteDocumentWithSubcollections(userUid);
        Navigator.pushReplacementNamed(context, '/homepage');
      }
    } catch(e){
      debugPrint('');
    }
  }


/*
  Future<List<String>> getFolderList(String userId) async {
    List<String> folderList = [];

    try {
      firebase_storage.ListResult result = await storage.ref('users').child(userId).listAll();
      for (var ref in result.prefixes) {
        String folderName = ref.fullPath.split('/').last;
        folderList.add(folderName);
        print(folderList.toString());
      }
    } catch (e) {
      debugPrint('getFolderList Hata: $e');
    }

    return folderList;
  }*/
}