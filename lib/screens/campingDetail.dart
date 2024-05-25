import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../product/hotelListCard.dart';
import '../product/navigationButton.dart';

class CampingDetailView extends StatefulWidget {
  const CampingDetailView(
      {Key? key,
      required this.list,
      required this.description,
      required this.location,
      required this.telNo,
      required this.rating,
      required this.campingName,
      required this.latitude,
      required this.longitude,
      this.owner})
      : super(key: key);

  final List<String> list;
  final String campingName;
  final String description;
  final String? owner;
  final String location;
  final String telNo;
  final String rating;
  final double latitude;
  final double longitude;

  @override
  State<CampingDetailView> createState() => _CampingDetailViewState();
}

class _CampingDetailViewState extends State<CampingDetailView> {
  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
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

    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.6,
              child: PageView(controller: _controller, children: images),
            ),
            Positioned(
                top: 20,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white),
                )),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                    child: Indicator(controller: _controller, list: images))),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.38,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white,
                    border: Border.all(
                        width: 1.5, color: ColorConstants.instance.titleColor)),
                height: ((MediaQuery.of(context).size.height) / 2) + 50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(children: [
                    Center(
                        child: NavigationButton(
                            latitude: widget.latitude,
                            longitude: widget.longitude)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.campingName,
                            style: TextFonts.instance.titleFont),
                        /*Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                              Text('500\$',style: TextFonts.instance.priceFont,),
                                Text('per night',style: TextFonts.instance.commentTextThin,)])*/
                      ],
                    ),
                    Text(widget.location,
                        style: TextFonts.instance.commentTextThin),
                    const SizedBox(height: 20),
                    Text('Tesis Özellikleri',
                        style: TextFonts.instance.middleTitle),
                    const SizedBox(height: 20),
                    Text(
                      widget.description,
                      style: TextFonts.instance.commentTextBold,
                    ),
                    const SizedBox(height: 20),
                    OwnerCard(
                        owner: widget.owner ?? widget.campingName,
                        telNumber: widget.telNo,
                        ),
                    const SizedBox(height: 30),
                  ]),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.36,
                right: 25,
                child: Container(
                  height: 40,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          width: 1, color: ColorConstants.instance.titleColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(widget.rating,
                          style: TextFonts.instance.commentTextThin)
                    ],
                  ),
                ))
          ],
          //overflow: Overflow.visible,
        ),
      ),
    );
  }
}
