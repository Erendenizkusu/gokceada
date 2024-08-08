import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RestaurantImage extends StatefulWidget {
  final String folderPath;

  const RestaurantImage({super.key, required this.folderPath});

  @override
  _RestaurantImageState createState() => _RestaurantImageState();
}

class _RestaurantImageState extends State<RestaurantImage> {
  String? imageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFirstImage();
  }

  Future<String> getFirstImageFromFolder(String folderPath) async {
    try {
      firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance
          .ref(folderPath)
          .listAll();

      if (result.items.isNotEmpty) {
        // İlk referansı al
        firebase_storage.Reference firstImageRef = result.items.first;
        // İndirme URL'sini al
        String downloadURL = await firstImageRef.getDownloadURL();
        return downloadURL;
      } else {
        throw Exception("Klasörde hiç resim bulunamadı");
      }
    } catch (e) {
      print('Error fetching first image: $e');
      throw e;
    }
  }

  Future<void> fetchFirstImage() async {
    try {
      String url = await getFirstImageFromFolder(widget.folderPath);
      if (mounted) {
        setState(() {
          imageUrl = url;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching image: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : imageUrl != null
        ? Image.network(imageUrl!, fit: BoxFit.cover)
        : const Center(child: Text('Resim bulunamadı'));
  }
}
