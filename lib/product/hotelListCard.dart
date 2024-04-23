import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelListCard extends StatefulWidget {
  const HotelListCard(
      {Key? key,
      required this.hotelName,
      required this.location,
      this.price = 0,
      required this.rating,
      required this.list})
      : super(key: key);
  final String hotelName;
  final String location;
  final int price;
  final String rating;
  final List<String> list;

  @override
  State<HotelListCard> createState() => _HotelListCardState();
}

class _HotelListCardState extends State<HotelListCard> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var images = widget.list
        .map((e) => Image.network(
              'https://drive.google.com/uc?export=view&id=$e',
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
            ))
        .toList();
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.55,
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
            child: PageView(controller: _controller, children: images),
          ),
          Indicator(controller: _controller, list: images),
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
                    ])
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required PageController controller,
    required this.list,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SmoothPageIndicator(
        controller: _controller,
        count: list.length,
        effect: SwapEffect(
          activeDotColor: ColorConstants.instance.activatedButton,
          dotColor: Colors.deepPurple.shade100,
          dotHeight: 10.0,
          dotWidth: 10.0,
          spacing: 15.0,
        ),
      ),
    );
  }
}
