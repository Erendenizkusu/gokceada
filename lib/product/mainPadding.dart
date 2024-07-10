import 'package:flutter/material.dart';

class PaddingPublic extends StatelessWidget {
  const PaddingPublic({super.key,required this.widget});

final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: widget,);
  }
}
