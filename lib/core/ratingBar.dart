import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({super.key, required this.rating});

  final String rating;

  @override
  Widget build(BuildContext context) {
    return PannableRatingBar(
      rate: (double.parse(rating)),
      maxRating: 5,
      minRating: 1,
      items: List.generate(5, (index) =>
      const RatingWidget(
        selectedColor: Colors.yellow,
        unSelectedColor: Colors.grey,
        child: Icon(
          Icons.star,
          size: 25,
        ),
      )),
      onChanged: (value) { // the rating value is updated on tap or drag.
        })
    ;
  }
}
