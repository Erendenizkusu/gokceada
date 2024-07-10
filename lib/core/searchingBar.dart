import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';

class searchingBar extends StatelessWidget {
  const searchingBar({
    super.key,required this.labelText,this.hintText
  });

  final String labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: TextField(

        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.instance.textFieldBacgroundColor,
          labelText: labelText,
          labelStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: 20,color: ColorConstants.instance.searcButtonColor),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: ColorConstants.instance.titleColor)),
          prefixIcon: Icon(Icons.search,color: ColorConstants.instance.searcButtonColor),

        ),
      ),
    );
  }
}