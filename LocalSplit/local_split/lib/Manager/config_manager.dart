import 'package:flutter/widgets.dart';
import 'package:local_split/Localization/localization.dart';
import 'package:local_split/Model/data.dart';

class ConfigManager {
  static final ConfigManager _singleton = ConfigManager._internal();
  ValueNotifier<Data> localeNotifier = ValueNotifier(Localization.supportLanguageDatas[1]);
  
  void setLocale(Data data){
    localeNotifier.value = data;
  }
  
  factory ConfigManager() {
    return _singleton;
  }

  ConfigManager._internal();
}