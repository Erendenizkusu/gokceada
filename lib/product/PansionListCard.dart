import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/twoImagePageView.dart';
import 'countIndicator.dart';

class PansionListCard extends StatefulWidget {
  const PansionListCard(
      {super.key,
      required this.hotelName,
      required this.location,
      required this.rating,
      required this.path});
  final String hotelName;
  final String location;
  final String rating;
  final String path;

  @override
  State<PansionListCard> createState() => _PansionListCardState();
}

class _PansionListCardState extends State<PansionListCard> {
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
            child: TwoImagePageView(controller: _controller,folderPath: widget.path,onImageCountUpdated: onImageCountUpdated),
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
                RatingBar(rating: widget.rating),
                const SizedBox(height: 15),
              ],
            ),
          )
          ]),
      ),
    );
  }
}
