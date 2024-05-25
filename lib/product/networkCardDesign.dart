import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';

class NetworkCardDesign extends StatelessWidget {
  const NetworkCardDesign(
      {Key? key, required this.path, required this.cardText})
      : super(key: key);
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
            child: Image.network(
          'https://drive.google.com/uc?export=view&id=$path',
          color: Colors.grey.withOpacity(0.9),
          colorBlendMode: BlendMode.modulate,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),),
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
