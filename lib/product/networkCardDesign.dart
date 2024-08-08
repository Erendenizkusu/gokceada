import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/restaurantCardImage.dart';

class NetworkCardDesign extends StatelessWidget {
  const NetworkCardDesign(
      {super.key, required this.path, required this.cardText});
  final String path;
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: (MediaQuery.of(context).size.height) * 0.3,
        child: Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          side:
              BorderSide(width: 2, color: ColorConstants.instance.titleColor)),
      child: Stack(alignment: Alignment.bottomLeft, children: [
      SizedBox(
      width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: RestaurantImage(folderPath: path)),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 20),
          child: Text(
            cardText,
            style: TextFonts.instance.imageFront,
          ),
        ),
      ]),
        ),
    );
  }
}
