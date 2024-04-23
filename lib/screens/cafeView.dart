import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/product/hotelListCard.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/textFont.dart';
import '../product/navigationButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CafeView extends StatefulWidget {
  const CafeView(
      {Key? key,
        required this.list,
        required this.rating,
        required this.name,
        required this.location,
        required this.link,
        required this.latitude,
        required this.longitude})
      : super(key: key);

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
                  AppLocalizations.of(context).menuBilgilendirme,
                  style: TextFonts.instance.commentTextBold),
              const SizedBox(height: 8),
              InkwellUnderline(
                  name: 'Web Site',
                  onTap: widget.link == '' ? () {
                    launchUrl(url);
                  } : (){ AlertDialog(
                    content: Text('Bu Restorant İçin Menu Bilgisi Bulunmuyor..'),
                    title: Text('Qr Menu Bulunmadı!'),
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
