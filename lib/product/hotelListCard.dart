import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/twoImagePageView.dart';
import 'countIndicator.dart';

class HotelListCard extends StatefulWidget {
  const HotelListCard({
    super.key,
    required this.hotelName,
    required this.location,
    this.price = 0,
    required this.rating,
    required this.path,
  });

  final String hotelName;
  final String location;
  final int price;
  final String rating;
  final String path;

  @override
  State<HotelListCard> createState() => _HotelListCardState();
}


class _HotelListCardState extends State<HotelListCard> {
  late PageController _controller;
  int imageCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void onImageCountUpdated(int count) {
    setState(() {
      imageCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.5, color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: (MediaQuery.of(context).size.height) * 0.35,
            child: TwoImagePageView(
              folderPath: widget.path,
              controller: _controller,
              onImageCountUpdated: onImageCountUpdated,
            ),
          ),
          CountIndicator(controller: _controller, count: imageCount),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.hotelName,
                        style: TextFonts.instance.commentTextBold,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorConstants.instance.activatedButton),
                        child: Center(child: Text(widget.rating)),
                      ),
                    ]),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: ColorConstants.instance.commentColor,
                    ),
                    Expanded(
                        child: Text(
                      widget.location,
                      style: TextFonts.instance.commentTextThin,
                      maxLines: 1,
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar(rating: widget.rating),
                      //Text('${widget.price}₺',style: TextFonts.instance.priceFont,)
                    ]),
                const SizedBox(height: 12),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

