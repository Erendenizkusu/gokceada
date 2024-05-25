import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Advices extends StatelessWidget {
  const Advices({Key? key}) : super(key: key);

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
        title: Text(AppLocalizations.of(context)!.tavsiyeler, style: TextFonts.instance.appBarTitleColor),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.instance.titleColor,width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Text(AppLocalizations.of(context)!.tavsiyeMetni, style: TextFonts.instance.commentTextBold),
      )));
  }
}
