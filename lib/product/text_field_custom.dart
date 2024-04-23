import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {Key? key,
      required this.label_text,
      required this.hint_text,
      required this.icon,
      this.controller,
      this.secretText = false})
      : super(key: key);

  final TextEditingController? controller;
  final String label_text;
  final String hint_text;
  final IconData icon;
  final bool secretText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
      obscureText: secretText,
      controller: controller,
      style: TextStyle(color: ColorConstants.instance.titleColor),
      // metin rengi
      cursorColor: Colors.white,
      // imleç rengi
      decoration: InputDecoration(
        labelText: label_text,
        hintText: hint_text,
        hintStyle: TextStyle(color: ColorConstants.instance.titleColor),
        // boşlukta görünecek metin rengi
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorConstants.instance.titleColor, // çerçeve rengi
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorConstants.instance.commentColor,
            // etkin olmayan çerçeve rengi
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ColorConstants.instance.titleColor,
            // odaklanıldığında çerçeve rengi
            width: 2,
          ),
        ),
      ),
      ),
    );
  }
}
