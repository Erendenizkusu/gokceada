import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'hotelListCard.dart';

class NetworkImageDescription extends StatefulWidget {
  const NetworkImageDescription({super.key,required this.title,required this.list,required this.description, this.widget});

  final String title;
  final String description;
  final List<String> list;
  final Widget? widget;

  @override
  State<NetworkImageDescription> createState() => _NetworkImageDescriptionState();
}
class _NetworkImageDescriptionState extends State<NetworkImageDescription> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    var images = widget.list.map((e) => Image.network('https://drive.google.com/uc?export=view&id=$e',fit: BoxFit.fill)).toList();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorConstants.instance.titleColor,
        title: Text(widget.title,style: TextFonts.instance.titleFont),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
        Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        height: (MediaQuery.of(context).size.height)*0.35,
        child: PageView(
            controller: controller,
            children:
            images
        ),
      ),
        Center(
            child: Indicator(controller: controller, list: images)),
          Center(child:widget.widget),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.description,style: TextFonts.instance.commentTextBold,),
          )
        ],
      ),
    );
  }

}
