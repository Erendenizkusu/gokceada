import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/card_design.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NerdeYenirView extends StatelessWidget {
  const NerdeYenirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      foregroundColor: ColorConstants.instance.titleColor,
      title: Text(AppLocalizations.of(context).neredeYenir, style: TextFonts.instance.appBarTitleColor),
      elevation: 0.8,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children:  [
            CardDesign(path: 'images/nerdeYenir/poseidon2.jpg', cardText: AppLocalizations.of(context).restoranlar, pushWhere: 'restaurantsView'),
            CardDesign(path: 'images/nerdeYenir/bar.jpg', cardText: AppLocalizations.of(context).barlar, pushWhere: 'bar'),
            CardDesign(path: 'images/nerdeYenir/cafe.jpg', cardText: AppLocalizations.of(context).kafeler, pushWhere: 'cafe'),
            CardDesign(path: 'images/nerdeYenir/kahvalti.jpg', cardText: AppLocalizations.of(context).kahvaltiYerleri, pushWhere: 'kahvalti'),
          ],
        ),
      ),
    );
  }
}
