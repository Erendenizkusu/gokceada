import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/textFont.dart';
import '../product/countIndicator.dart';
import '../product/imagePageView.dart';
import '../product/navigationButton.dart';


class CafeView extends StatefulWidget {
  const CafeView(
      {super.key,
        required this.path,
        required this.rating,
        required this.name,
        required this.location,
        required this.link,
        required this.latitude,
        required this.longitude});

  final String path;
  final String rating;
  final String name;
  final String location;
  final String link;
  final double latitude;
  final double longitude;

  @override
  State<CafeView> createState() => _CafeViewState();
}

class _CafeViewState extends State<CafeView> {
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
    var url = Uri.parse(widget.link);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: (MediaQuery.of(context).size.height) * 0.35,
            child: ImagePageView(controller: _controller, folderPath: widget.path,onImageCountUpdated: onImageCountUpdated),
          ),
          Center(child: CountIndicator(controller: _controller, count: imageCount)),
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
                  onTap: widget.link == '' ? () {
                    launchUrl(url);
                  } : (){ AlertDialog(
                    content: const Text('Bu Restorant İçin Menu Bilgisi Bulunmuyor..'),
                    title: const Text('Qr Menu Bulunmadı!'),
                    backgroundColor: ColorConstants.instance.activatedButton,
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Tamam butonuna tıklandığında yapılacak işlemler
                          Navigator.of(context).pop(); // Bildirimi kapat
                        }, child: Text('Tamam',style: TextFonts.instance.commentTextThin),
                      ),
                    ],

                  );}
                  ),
            ]),
          )
        ]),
      ]),
    );
  }
}
