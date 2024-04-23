import 'package:flutter/material.dart';
import 'package:gokceada/classes/language_constants.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/main.dart';

import '../classes/language.dart';
import '../core/textFont.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      padding: EdgeInsets.only(top: 4),
      dropdownColor: ColorConstants.instance.titleColor,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.language,
          size: 30,
          color: Colors.white,
        ),
        onChanged: (Language? language) async{
          if(language != null){
            Locale _locale = await setLocale(language.languageCode);
            Gokceada.setLocale(context, _locale);
          }
        },
        items: Language.languageList().map<DropdownMenuItem<Language>>((e) => DropdownMenuItem<Language>(
            value: e,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                e.flag,
                Text(e.name,style: TextFonts.instance.smallText)
              ],
            )
        ),
        ).toList(),
    );
  }
}
