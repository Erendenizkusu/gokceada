import 'package:flutter/material.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../core/colors.dart';

class DescriptionCustom extends StatefulWidget {
  const DescriptionCustom({Key? key,required this.title,required this.images,required this.description, this.widget}) : super(key: key);

  final String title;
  final String description;
  final List<ImageCardDesign> images;
  final Widget? widget;

  @override
  State<DescriptionCustom> createState() => _DescriptionCustomState();
}
class _DescriptionCustomState extends State<DescriptionCustom> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextFonts.instance.titleFont),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: leadingArrow(context),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          CircularImagesTop(list: widget.images),
          Center(child:widget.widget),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.description,style: TextFonts.instance.commentTextBold,),
          )
        ],
      ),
    );
  }

  IconButton leadingArrow(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_new,color: ColorConstants.instance.titleColor,),
      );
  }
}
