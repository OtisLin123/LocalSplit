import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_split/Localization/languages.dart';
import 'package:local_split/Manager/config_manager.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Manager/person_manager.dart';
import 'package:local_split/Router/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'Localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GroupManager().init();
  PersonManager().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return GetMaterialApp(
      title: 'Local Split',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      fallbackLocale: Localization.supportLanguagesLocales()[0],
      locale: ConfigManager().localeNotifier.value.data as Locale,
      initialRoute: AppPages.Initial,
      getPages: AppPages.routes,
    );
  }
}
