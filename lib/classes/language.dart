import 'package:flutter/cupertino.dart';

class Language{
  final int id;
  final String name;
  final Image flag;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode, );

  static List<Language> languageList(){
    return <Language>[
      Language(1, Image.asset('images/turkey.png',height: 40,width: 40), 'Türkçe', 'tr'),
      Language(2, Image.asset('images/usa.png',height: 40,width: 40), 'English', 'en'),
    ];
  }
}