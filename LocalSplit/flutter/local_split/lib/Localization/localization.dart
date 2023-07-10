import 'package:flutter/cupertino.dart';
import 'package:local_split/Model/data.dart';

class Localization {

  static List<Data> supportLanguageDatas = [
    Data(text: "繁體中文", data: const Locale('zh', 'TW')),
    Data(text: "English", data: const Locale('en', 'US')),
  ];

  static List<Locale> supportLanguagesLocales(){
    List<Locale> result = [];
    for (Data supportLanguageData in supportLanguageDatas){
      result.add(supportLanguageData.data);
    }
    return result;
  }

  static List<String> supportLanguageNames(){
    List<String> result = [];
    for (Data supportLanguageData in supportLanguageDatas){
      result.add(supportLanguageData.text);
    }
    return result;
  }
}
