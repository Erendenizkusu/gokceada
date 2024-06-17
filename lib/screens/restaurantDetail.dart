import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/product/hotelListCard.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/textFont.dart';
import '../product/navigationButton.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView(
      {Key? key,
      required this.list,
      required this.rating,
      required this.name,
      required this.location,
      required this.link,
      required this.telNo,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  final List<String> list;
  final String rating;
  final String name;
  final String location;
  final String link;
  final String telNo;
  final double latitude;
  final double longitude;

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  Widget build(BuildContext context) {
    final _controller = PageController();
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
    var url = Uri.parse(widget.link);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: (MediaQuery.of(context).size.height) * 0.35,
            child: PageView(controller: _controller, children: images),
          ),
          Center(child: Indicator(controller: _controller, list: images)),
          const SizedBox(height: 10),
          Center(
              child: NavigationButton(latitude: widget.latitude,longitude: widget.longitude),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RatingBar(rating: widget.rating),
              const SizedBox(height: 10),
              Text(
                widget.name,
                style: TextFonts.instance.titleFont,
              ),
              Text(
                widget.location,
                style: TextFonts.instance.commentTextThin,
              ),
              const SizedBox(height: 30),
              Text(
                  'menuBilgilendirme'.tr(),
                  style: TextFonts.instance.commentTextBold),
              const SizedBox(height: 8),
              InkwellUnderline(
                  name: 'QR Menu',
                  onTap: () {
                    launchUrl(url);
                  }),
              const SizedBox(height: 15),
              OwnerCard(
                  owner: widget.name,
                  telNumber: widget.telNo,
                  ),
            ]),
          )
        ]),
      ]),
    );
  }
}

class CircularImagesTop extends StatelessWidget {
  CircularImagesTop({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<ImageCardDesign> list;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: (MediaQuery.of(context).size.height) * 0.4,
        width: (MediaQuery.of(context).size.width),
        child: PageView(
          children: list,
          controller: _controller,
        ),
      ),
      Indicator(controller: _controller, list: list)
    ]);
  }
}

class ImageCardDesign extends StatelessWidget {
  const ImageCardDesign({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Image.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}

class InkwellUnderline extends StatelessWidget {
  const InkwellUnderline({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        name,
        style: TextFonts.instance.underlineFont,
      ),
    );
  }
}
