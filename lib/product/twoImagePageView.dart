import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class TwoImagePageView extends StatefulWidget {
  final String folderPath;
  final Function(int) onImageCountUpdated;

  const TwoImagePageView({super.key, required this.folderPath, required PageController controller, required this.onImageCountUpdated,}): _controller = controller;
  final PageController _controller;

  @override
  TwoImagePageViewState createState() => TwoImagePageViewState();
}

class TwoImagePageViewState extends State<TwoImagePageView> {
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<List<String>> getImagesFromStorage(String folderPath) async {
    List<String> imageUrls = [];

    try {
      firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance
          .ref(folderPath)
          .listAll();

      // İlk iki dosyayı almak için
      int limit = result.items.length > 2 ? 2 : result.items.length;
      for (int i = 0; i < limit; i++) {
        String downloadURL = await result.items[i].getDownloadURL();
        imageUrls.add(downloadURL);
      }
    } catch (e) {
      print('Error fetching images: $e');
    }

    return imageUrls;
  }

  Future<void> fetchImages() async {
    List<String> urls = await getImagesFromStorage(widget.folderPath);

    if (mounted) {
      setState(() {
        imageUrls = urls;
        isLoading = false;
      });
      widget.onImageCountUpdated(urls.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
          ? const Center(child: CircularProgressIndicator())
          :
      PageView(
      controller: widget._controller,
      children: imageUrls.map((url) {
        return Image.network(url, fit: BoxFit.fill);
      }).toList(),
    );
  }

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }
}

