import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/card_design.dart';

class Koyler extends StatelessWidget {
  const Koyler({super.key});

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
          title: Text('koyler'.tr(), style: TextFonts.instance.appBarTitleColor),
        ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            CardDesign(path: 'images/koyler/bademli.jpg', cardText: 'Bademli', koyNames: 'bademli'),
            CardDesign(path: 'images/koyler/derekoy.jpg', cardText: 'Derekoy', koyNames: 'derekoy'),
            CardDesign(path: 'images/koyler/eselek.jpg', cardText: 'Eşelek Köyü', koyNames: 'eselek'),
            CardDesign(path: 'images/koyler/kalekoy.jpg', cardText: 'Yukarı Kalelöy', koyNames: 'kalekoy'),
            CardDesign(path: 'images/koyler/kalekoy_limani.jpg', cardText: 'Kaleköy', koyNames: 'kalekoyLiman'),
            CardDesign(path: 'images/koyler/panaghia.jpg', cardText: 'Merkez', koyNames: 'merkez'),
            CardDesign(path: 'images/koyler/sahinkaya.jpg', cardText: 'Şahinkaya Köyü', koyNames: 'sahinkaya'),
            CardDesign(path: 'images/koyler/sirinkoy.jpg', cardText: 'Şirinköy', koyNames: 'sirinkoy'),
            CardDesign(path: 'images/koyler/tepekoy.jpg', cardText: 'Tepeköy', koyNames: 'tepekoy'),
            CardDesign(path: 'images/koyler/ugurlu.jpg', cardText: 'Uğurlu Köyü', koyNames: 'ugurlu'),
            CardDesign(path: 'images/koyler/yenibademli.jpg', cardText: 'Yenibademli Köyü', koyNames: 'yenibademli'),
            CardDesign(path: 'images/koyler/zeytinlikoy.jpg', cardText: 'Zeytinliköy', koyNames: 'zeytinlikoy'),
          ],
        ),
      ),
    );
  }
}
