import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'countIndicator.dart';
import 'imagePageView.dart';

class NetworkImageDescription extends StatefulWidget {
  const NetworkImageDescription({super.key,required this.title,required this.path,required this.description, this.widget});

  final String title;
  final String description;
  final String path;
  final Widget? widget;

  @override
  State<NetworkImageDescription> createState() => _NetworkImageDescriptionState();
}
class _NetworkImageDescriptionState extends State<NetworkImageDescription> {
  late PageController _controller;
  int imageCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void onImageCountUpdated(int count) {
    setState(() {
      imageCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: ImagePageView(
            controller: _controller,
            onImageCountUpdated: onImageCountUpdated,
            folderPath: widget.path,
        ),
      ),
        Center(
            child: CountIndicator(controller: _controller, count: imageCount)),
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
