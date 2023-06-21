import 'package:flutter/material.dart';

class LoadingManager {
  static final LoadingManager _singleton = LoadingManager._internal();

  bool isShow = false;
  BuildContext? parent;

  void show({required BuildContext context, Widget? child}) {
    if (isShow) {
      return;
    }
    parent = context;
    isShow = true;
    showGeneralDialog(
      context: parent!,
      barrierColor: const Color(0xCCFFFFFF),
      pageBuilder: (context, animation, secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: child ?? Container(width: 80, height: 80, color: Colors.red),
          ),
        );
      },
    );
  }

  void close() {
    if (!isShow || parent == null) {
      return;
    }

    Navigator.of(parent!, rootNavigator: true).pop();
    isShow = false;
  }

  factory LoadingManager() {
    return _singleton;
  }

  LoadingManager._internal();
}
