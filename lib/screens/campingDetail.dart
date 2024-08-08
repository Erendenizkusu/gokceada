import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../product/countIndicator.dart';
import '../product/imagePageView.dart';
import '../product/navigationButton.dart';

class CampingDetailView extends StatefulWidget {
  const CampingDetailView(
      {super.key,
      required this.path,
      required this.description,
      required this.location,
      required this.telNo,
      required this.rating,
      required this.campingName,
      required this.latitude,
      required this.longitude,
      this.owner});

  final String path;
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
              child: ImagePageView(controller: _controller,folderPath: widget.path,onImageCountUpdated: onImageCountUpdated),
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
                    child: CountIndicator(controller: _controller, count: imageCount))),
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
