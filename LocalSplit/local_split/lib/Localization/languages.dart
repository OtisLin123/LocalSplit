import 'package:get/get.dart';
import 'package:local_split/i18n/en_US.dart';
import 'package:local_split/i18n/zh_TW.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'zh_TW': zh_TW,
      };
}
