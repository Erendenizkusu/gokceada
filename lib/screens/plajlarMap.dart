import 'package:flutter/material.dart';
import '../product/navigationButton.dart';
import '../product/plaj_inside_design.dart';
import 'restaurantDetail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Map<String, Widget> plajlar(BuildContext context) {
  return {
    'yildizkoy': DescriptionCustom(
        title: 'Yildizkoy',
        images: const [
          ImageCardDesign(image: 'images/yildizkoy/yildizkoy.jpg'),
          ImageCardDesign(image: 'images/yildizkoy/yildizkoy2.jpg'),
          ImageCardDesign(image: 'images/yildizkoy/yildizkoy3.jpg'),
          ImageCardDesign(image: 'images/yildizkoy/yildizkoy4.jpg'),
          ImageCardDesign(image: 'images/yildizkoy/yildizkoy5.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.234883968629745, longitude: 25.90356574599544),
        description: AppLocalizations.of(context).yildizkoy),

    'kefalos': DescriptionCustom(
        title: 'Kefalos',
        images: const [
          ImageCardDesign(image: 'images/kefalos/kefalos1.jpg'),
          ImageCardDesign(image: 'images/kefalos/kefalos3.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.234883968629745, longitude: 25.90356574599544),
        description: AppLocalizations.of(context).kefalos),

    'marmaros': DescriptionCustom(
        title: 'Marmaros',
        images: const [
          ImageCardDesign(image: 'images/marmaros/marmaros.jpg'),
          ImageCardDesign(image: 'images/marmaros/marmaros1.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.19446916638958, longitude: 25.754652784576802),
        description: AppLocalizations.of(context).marmaros),

    'lazkoyu': DescriptionCustom(
        title: 'Laz Koyu',
        images: const [
          ImageCardDesign(image: 'images/lazkoyu/lazkoyu.jpg'),
          ImageCardDesign(image: 'images/lazkoyu/lazkoyu1.jpg'),
          ImageCardDesign(image: 'images/lazkoyu/lazkoyu2.jpg'),
          ImageCardDesign(image: 'images/lazkoyu/lazkoyu3.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.0995567867188, longitude: 25.783614569737185),
        description: AppLocalizations.of(context).lazkoyu),

    'gizliliman': DescriptionCustom(
        title: 'Gizli Liman',
        images: const [
          ImageCardDesign(image: 'images/gizliliman/gizliliman.jpg'),
          ImageCardDesign(image: 'images/gizliliman/gizliliman1.jpg'),
          ImageCardDesign(image: 'images/gizliliman/gizliliman2.jpg'),
          ImageCardDesign(image: 'images/gizliliman/gizliliman3.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.124907393869215, longitude: 25.672960645906578),
        description: AppLocalizations.of(context).gizliliman),

    'kuzulimanı': DescriptionCustom(
        title: 'Kuzu Limanı',
        images: const [
          ImageCardDesign(image: 'images/kuzulimani/kuzulimanı3.jpg'),
          ImageCardDesign(image: 'images/kuzulimani/kuzulimanı1.jpg'),
          ImageCardDesign(image: 'images/kuzulimani/kuzulimanı2.jpg'),
          ImageCardDesign(image: 'images/kuzulimani/kuzulimanı5.jpg'),
          ImageCardDesign(image: 'images/kuzulimani/kuzulimanı.jpg'),
          ImageCardDesign(image: 'images/kuzulimani/kuzulimanı4.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.22485472944999, longitude: 25.95067866788716),
        description: AppLocalizations.of(context).kuzulimani)
  };
}

