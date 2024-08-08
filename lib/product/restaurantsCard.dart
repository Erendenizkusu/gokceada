import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/restaurantCardImage.dart';

class RestaurantsCard extends StatefulWidget {
  const RestaurantsCard({super.key,required this.path,
    required this.restaurantName,
    required this.rating});

  final String path;
  final String restaurantName;
  final String rating;

  @override
  State<RestaurantsCard> createState() => _RestaurantsCardState();
}

class _RestaurantsCardState extends State<RestaurantsCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.3,
      width: 300,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorConstants.instance.titleColor),
        ),
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: RestaurantImage(folderPath: widget.path)),
            Positioned(
                bottom: 40,
                left: 20,
                child:
                Text(widget.restaurantName, style: TextFonts.instance.imageFront)),
            Positioned(bottom: 10, right: 20, child: RatingBar(rating: widget.rating))
          ],
        ),
      ),
    );
  }
}

/*
class RestaurantsCard extends StatelessWidget {
  const RestaurantsCard(
      {super.key,
      required this.path,
      required this.restaurantName,
      required this.rating});

  final String path;
  final String restaurantName;
  final String rating;

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.3,
      width: 300,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorConstants.instance.titleColor),
        ),
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ),
            Positioned(
                bottom: 40,
                left: 20,
                child:
                    Text(restaurantName, style: TextFonts.instance.imageFront)),
            Positioned(bottom: 10, right: 20, child: RatingBar(rating: rating))
          ],
        ),
      ),
    );
  }
}
 */