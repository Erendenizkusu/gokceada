import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void openMapsApp(double latitude, double longitude) async {
  String mapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

  if (await canLaunch(mapsUrl)) {
    await launch(mapsUrl);
  } else {
    throw 'Haritalar uygulaması açılamadı: $mapsUrl';
  }
}




class NavigationButton extends StatelessWidget {
  const NavigationButton({Key? key,required this.longitude,required this.latitude}) : super(key: key);

  final double latitude;
  final double longitude;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () {
        double destinationLatitude = latitude; // Hedef noktanın enlem değeri
        double destinationLongitude = longitude; // Hedef noktanın boylam değeri
        openMapsApp(destinationLatitude, destinationLongitude);
      },
      child: Text(AppLocalizations.of(context).yolTarifi),
      style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.instance.activatedButton),
    );
  }
}

