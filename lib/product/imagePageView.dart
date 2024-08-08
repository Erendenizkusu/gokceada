import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImagePageView extends StatefulWidget {
  final String folderPath;
  final Function(int) onImageCountUpdated;

  const ImagePageView({super.key, required this.folderPath, required PageController controller, required this.onImageCountUpdated,}): _controller = controller;
  final PageController _controller;

  @override
  ImagePageViewState createState() => ImagePageViewState();
}

class ImagePageViewState extends State<ImagePageView> {
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

      for (firebase_storage.Reference ref in result.items) {
        String downloadURL = await ref.getDownloadURL();
        imageUrls.add(downloadURL);
      }
    } catch (e) {
      debugPrint('Error fetching images: $e');
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
          : PageView(
        controller: widget._controller,
        children: imageUrls.map((url) {
          return Image.network(url,fit: BoxFit.fill);
        }).toList(),
    );
  }

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }
}
