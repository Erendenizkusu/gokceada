import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/product/hotelListCard.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../core/textFont.dart';
import '../helper/webview.dart';
import '../product/navigationButton.dart';


class CafeView extends StatefulWidget {
  const CafeView(
      {super.key,
        required this.list,
        required this.rating,
        required this.name,
        required this.location,
        required this.link,
        required this.latitude,
        required this.longitude});

  final List<String> list;
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
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
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
    final String url = widget.link;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: (MediaQuery.of(context).size.height) * 0.35,
            child: PageView(controller: controller, children: images),
          ),
          Center(child: Indicator(controller: controller, list: images)),
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
                  onTap: widget.link != '' ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WebViewComponent(url: url,title: 'QR MENU',)),
                    );
                  } : () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text('Bu Restorant İçin Menu Bilgisi Bulunmuyor..'),
                          title: const Text('Qr Menu Bulunmadı!'),
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
                  }

              ),
            ]),
          )
        ]),
      ]),
    );
  }
}
