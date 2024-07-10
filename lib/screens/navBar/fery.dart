import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';


class Feribot extends StatefulWidget {
  const Feribot({super.key});

  @override
  State<Feribot> createState() => _FeribotState();
}

class _FeribotState extends State<Feribot> {

  @override
  Widget build(BuildContext context) {

    var url = Uri.parse('https://www.gdu.com.tr/sefer-tarifeleri');

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
        title: Text('feribotSaatleri'.tr(), style: TextFonts.instance.appBarTitleColor),
      ),
      body: ListView(
        children:[
          Image.asset('images/gestas.jpg',fit: BoxFit.fill),
          Center(child: SizedBox(width: (MediaQuery.of(context).size.width)*0.5,child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.instance.activatedButton),
                  onPressed: (){
                    launchUrl(url);
                  },
                  child: Text('feribotSaatleri'.tr(),style: TextFonts.instance.smallText,)
          ),),),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(color: ColorConstants.instance.titleColor,height: 1,thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('feribilgi'.tr(),style: TextFonts.instance.commentTextBold,),
          )
      ])
    );
  }
}
