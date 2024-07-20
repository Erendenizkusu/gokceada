import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../helper/webview.dart';


class BusTimes extends StatefulWidget {
  const BusTimes({super.key});

  @override
  State<BusTimes> createState() => _BusTimesState();
}

class _BusTimesState extends State<BusTimes> {

  @override
  Widget build(BuildContext context) {

    const String url = 'https://www.gokceada.bel.tr/otobus-saatleri';

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
          title: Text('otobusSaatleri'.tr(), style: TextFonts.instance.appBarTitleColor),
        ),
        body: ListView(
            children:[
              Image.asset('images/otobus.jpg',fit: BoxFit.contain),
              Center(child: SizedBox(width: (MediaQuery.of(context).size.width)*0.5,child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.instance.activatedButton),
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WebViewComponent(url: url,title: 'otobusSaatleri'.tr(),)),
                    );
                  },
                  child: Text('otobusSaatleri'.tr(),style: TextFonts.instance.smallText,)
              ),),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Divider(color: ColorConstants.instance.titleColor,height: 1,thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('otobusBilgi'.tr(),style: TextFonts.instance.commentTextBold,),
              )
            ])
    );
  }
}