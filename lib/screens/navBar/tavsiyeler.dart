import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';

class Advices extends StatelessWidget {
  const Advices({super.key});

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
        title: Text('tavsiyeler'.tr(), style: TextFonts.instance.appBarTitleColor),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.instance.titleColor,width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Text('tavsiyeMetni'.tr(), style: TextFonts.instance.commentTextBold),
      )));
  }
}
