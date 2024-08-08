import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/navigationButton.dart';

class AtmList extends StatelessWidget {
  const AtmList({super.key});

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
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstants.instance.titleColor,
          ),
        ),
        title: Text('atm'.tr(), style: TextFonts.instance.appBarTitleColor),
      ),
      body: const Column(
        children: [
          SizedBox(height: 10),
          AtmListTile(
              path: 'images/atm/garantiBBVA.png',
              lat: 40.193737789565134,
              lng: 25.905316171736626),
          AtmListTile(
              path: 'images/atm/ziraatBankası.png',
              lat: 40.193688939321966,
              lng: 25.904497455892045),
          AtmListTile(
              path: 'images/atm/isBankası.png',
              lat: 40.193555653709055,
              lng: 25.904640218635492),
          AtmListTile(
              path: 'images/atm/halkbank.png',
              lat: 40.193703027777545,
              lng: 25.905289126200167),
        ],
      ),
    );
  }
}

class AtmListTile extends StatelessWidget {
  const AtmListTile({
    super.key,
    required this.path,
    required this.lat,
    required this.lng,
  });

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
            openMapsApp(context, lat, lng);
          },
          leading: Image.asset(path, width: 140, height: 70)),
    );
  }
}
