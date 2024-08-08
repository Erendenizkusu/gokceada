import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../core/colors.dart';

void openMapsApp(BuildContext context, double latitude, double longitude) async {
  Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude');
  Uri appleMapsUrl = Uri.parse('https://maps.apple.com/?daddr=$latitude,$longitude');

  bool canLaunchAppleMaps = await canLaunchUrl(appleMapsUrl);
  bool canLaunchGoogleMaps = await canLaunchUrl(googleMapsUrl);

  if (context.mounted && Platform.isIOS && canLaunchAppleMaps && canLaunchGoogleMaps) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('haritaSec'.tr()),
          content: const Text('Hangi harita uygulamasıyla açmak istersiniz?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Apple Maps'),
              onPressed: () {
                Navigator.of(context).pop();
                launchUrl(appleMapsUrl);
              },
            ),
            TextButton(
              child: const Text('Google Maps'),
              onPressed: () {
                Navigator.of(context).pop();
                launchUrl(googleMapsUrl);
              },
            ),
          ],
        );
      },
    );
  } else if (canLaunchGoogleMaps) {
    await launchUrl(googleMapsUrl);
  } else if (canLaunchAppleMaps) {
    await launchUrl(appleMapsUrl);
  } else {
    throw 'Hiçbir harita uygulaması açılamadı';
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
        openMapsApp(context, latitude, longitude);
      },
      style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.instance.activatedButton),
      child: Text('yolTarifi'.tr(), style: const TextStyle(color: Colors.white)),
    );
  }
}
