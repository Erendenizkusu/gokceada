import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../helper/webview.dart';
import '../product/countIndicator.dart';
import '../product/imagePageView.dart';
import '../product/navigationButton.dart';

class SurfingView extends StatefulWidget {
  const SurfingView(
      {super.key,
      required this.path,
      this.name,
      required this.location,
      required this.link,
      required this.telNo,
      required this.latitude,
      required this.longitude,
      required this.rating,
      required this.surfingName});

  final String path;
  final String? name;
  final String surfingName;
  final String rating;
  final String location;
  final String link;
  final String telNo;
  final double latitude;
  final double longitude;

  @override
  State<SurfingView> createState() => _SurfingViewState();
}

class _SurfingViewState extends State<SurfingView> {
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
    var url = widget.link;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: (MediaQuery.of(context).size.height) * 0.35,
            child: ImagePageView(controller: _controller, onImageCountUpdated: onImageCountUpdated,folderPath: widget.path),
          ),
          Center(child: CountIndicator(controller: _controller, count: imageCount)),
          const SizedBox(height: 10),
          Center(
              child: NavigationButton(
                  latitude: widget.latitude, longitude: widget.longitude)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RatingBar(rating: widget.rating),
              const SizedBox(height: 10),
              Text(
                widget.surfingName,
                style: TextFonts.instance.titleFont,
              ),
              Text(
                widget.location,
                style: TextFonts.instance.commentTextThin,
              ),
              const SizedBox(height: 30),
              Text(
                  'dahaFazlaBilgi'.tr(),
                  style: TextFonts.instance.commentTextBold),
              const SizedBox(height: 8),
              InkwellUnderline(
                  name: 'Website',
                  onTap: widget.link != '' ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WebViewComponent(url: url,title: 'surfOkullari'.tr(),)),
                    );
                  } : () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text('Website Mevcut Değil!'),
                          title: const Text('Website Bulunamadı!'),
                          backgroundColor: ColorConstants.instance.lightGreyCardCollor,
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Tamam butonuna tıklandığında yapılacak işlemler
                                Navigator.of(context).pop(); // Bildirimi kapat
                              },
                              child: Text('Tamam', style: TextFonts.instance.commentTextThin),
                            ),
                          ],
                        );
                      },
                    );
                  }),
              const SizedBox(height: 15),
              OwnerCard(
                  owner: widget.name ?? widget.surfingName,
                  telNumber: widget.telNo,
                  )
            ]),
          ),
        ]),
      ]),
    );
  }
}
