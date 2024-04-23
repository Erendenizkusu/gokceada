import 'package:flutter/material.dart';

class PaddingPublic extends StatelessWidget {
  const PaddingPublic({Key? key,required this.widget}) : super(key: key);

final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: widget,);
  }
}
