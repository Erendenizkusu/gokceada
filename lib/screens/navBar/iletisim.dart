import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Iletisim extends StatelessWidget {
  const Iletisim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url1 = Uri.parse('mailto:gokceadamobile@gmail.com');
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
          title: Text(AppLocalizations.of(context)!.iletisim, style: TextFonts.instance.appBarTitleColor),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const SizedBox(height: 10),
              Text(
                  AppLocalizations.of(context)!.iletisimNot,
                  style: TextFonts.instance.commentTextBold),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  launchUrl(url1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ColorConstants.instance.titleColor, width: 1)),
                  child: ListTile(
                      leading: const Icon(Icons.mail),
                      title: Text('gokceadamobile@gmail.com',
                          style: TextFonts.instance.commentTextThin)),
                ),
              )
            ])));
  }
}
