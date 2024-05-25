import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AtmList extends StatelessWidget {
  const AtmList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.7,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new, color: ColorConstants.instance.titleColor,),
          ),
          title: Text(AppLocalizations.of(context)!.atm, style: TextFonts.instance.appBarTitleColor),
        ),
      body: const Column(
        children: [
          SizedBox(height: 10),
          AtmListTile(path: 'images/atm/garantiBBVA.png',lat: 40.193737789565134,lng: 25.905316171736626),
          AtmListTile(path: 'images/atm/ziraatBankası.png',lat: 40.193688939321966,lng: 25.904497455892045),
          AtmListTile(path: 'images/atm/isBankası.png',lat: 40.193555653709055,lng: 25.904640218635492),
        ],
      ),
    );
  }
}

class AtmListTile extends StatelessWidget {
  const AtmListTile({
    Key? key, required this.path, required this.lat, required this.lng,
  }) : super(key: key);

  final String path;
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.instance.titleColor,
          width: 1.0,
        ),
      ),
      child: ListTile(
        onTap: () {
          openMapsApp(lat,lng);
        },
          leading: Image.asset(path,width: 140,height: 70)),
    );
  }
  void openMapsApp(double latitude, double longitude) async {
    String mapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw 'Haritalar uygulaması açılamadı: $mapsUrl';
    }
  }
}

