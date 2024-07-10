import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/koylerMap.dart';

  class CardDesign extends StatelessWidget {
    const CardDesign({super.key,this.koyNames ,required this.path,required this.cardText,this.pushWhere = ''});
    final String path;
    final String cardText;
    final String? pushWhere;
    final String? koyNames;
    @override
    Widget build(BuildContext context) {

      return InkWell(
        onTap: koyNames != null ? () {
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => createKoyler(context)[koyNames] as Widget,
              ));
        } : (){
          Navigator.of(context).pushNamed('/$pushWhere');
        },
        child: SizedBox(
          height: (MediaQuery.of(context).size.height)*0.24,
          child: Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(bottom: 5),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
                Radius.circular(10)
            ),
            side: BorderSide(width: 2,color: ColorConstants.instance.titleColor)
          ),

          child: Stack(
            alignment: Alignment.bottomLeft,
            children:[
              Image.asset(path,
                height: (MediaQuery.of(context).size.height),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30,left: 20),
                  child: Text(
                    cardText,
                    style: TextFonts.instance.imageFront,
                  ),
                ),
          ]
          ),
        ),
        ),
      );
    }
  }

