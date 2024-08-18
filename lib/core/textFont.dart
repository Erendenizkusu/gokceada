import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';

class TextFonts {
  static TextFonts instance = TextFonts._init();

  TextFonts._init();

  final smallText =
  const TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 13.5,
    fontStyle: FontStyle.normal,
  );

  final middleTitle =
  TextStyle(
    fontFamily: 'Poppins',
    fontSize: 23,
    color: ColorConstants.instance.titleColor,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  final appBarTitle =
  const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 23,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  final appBarTitleColor =
  TextStyle(
    fontFamily: 'Poppins',
    fontSize: 26,
    color: ColorConstants.instance.titleColor,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  final commentTextBold =
  TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: ColorConstants.instance.commentColor,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
      );

  final explanationTextBold =
  TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: ColorConstants.instance.titleColor,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  final commentTextThin =
  TextStyle(
    fontFamily: 'Poppins',
    //font size 18' idi
    fontSize: 17,
    color: ColorConstants.instance.commentColor,
    fontWeight: FontWeight.w100,
    fontStyle: FontStyle.normal,
  );

  final titleFont =
  TextStyle(
            fontFamily: 'Poppins',
            color: ColorConstants.instance.titleColor,
            fontSize: 23,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,

  );

    final imageFront =
  TextStyle(
  fontFamily: 'Poppins',
    color: ColorConstants.instance.imageFrontTextColor,
    fontSize: 30,
  fontWeight: FontWeight.w800,
  fontStyle: FontStyle.normal,
  );

    final priceFont =
        TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: ColorConstants.instance.titleColor,
        );

    final underlineFont =
        TextStyle(
          fontFamily: 'Poppins',
          color: ColorConstants.instance.titleColor,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w600,
          fontSize: 16,

        );

    final imageFrontRating = TextStyle(
      fontFamily: 'Montserrat',
      color: ColorConstants.instance.imageFrontTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

  final middleWhiteColor = TextStyle(
    fontFamily: 'Montserrat',
    color: ColorConstants.instance.imageFrontTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

}
