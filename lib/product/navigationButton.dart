import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import 'dart:io';

void openMapsApp(double latitude, double longitude) async {
  Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude');
  Uri appleMapsUrl = Uri.parse('https://maps.apple.com/?daddr=$latitude,$longitude'); //Uri.parse('maps:q=$query');

  Uri mapsUrl = Platform.isIOS ? appleMapsUrl : googleMapsUrl;

  if (await canLaunchUrl(mapsUrl)) {
    await launchUrl(mapsUrl);
  } else {
    throw 'Haritalar uygulaması açılamadı: $mapsUrl';
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        openMapsApp(latitude, longitude);
      },
      style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.instance.activatedButton),
      child: Text('yolTarifi'.tr(), style: const TextStyle(color: Colors.white)),
    );
  }
}