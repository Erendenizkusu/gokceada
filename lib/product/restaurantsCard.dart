import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/core/textFont.dart';

class RestaurantsCard extends StatelessWidget {
  const RestaurantsCard(
      {Key? key,
      required this.path,
      required this.restaurantName,
      required this.rating})
      : super(key: key);

  final String path;
  final String restaurantName;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Container(
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
                )),
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
