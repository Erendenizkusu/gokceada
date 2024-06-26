import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/card_design.dart';

class NerdeYenirView extends StatefulWidget {
  const NerdeYenirView({super.key});

  @override
  State<NerdeYenirView> createState() => _NerdeYenirViewState();
}

class _NerdeYenirViewState extends State<NerdeYenirView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: ColorConstants.instance.titleColor,
        title: Text('neredeYenir'.tr(), style: TextFonts.instance.appBarTitleColor),
        elevation: 0.8,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children:  [
            CardDesign(path: 'images/nerdeYenir/poseidon2.jpg', cardText: 'restoranlar'.tr(), pushWhere: 'restaurantsView'),
            CardDesign(path: 'images/nerdeYenir/bar.jpg', cardText: 'barlar'.tr(), pushWhere: 'bar'),
            CardDesign(path: 'images/nerdeYenir/cafe.jpg', cardText: 'kafeler'.tr(), pushWhere: 'cafe'),
            CardDesign(path: 'images/nerdeYenir/kahvalti.jpg', cardText: 'kahvaltiYerleri'.tr(), pushWhere: 'kahvalti'),
          ],
        ),
      ),
    );
  }
}

