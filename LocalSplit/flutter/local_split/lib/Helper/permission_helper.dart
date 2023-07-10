import 'package:permission_handler/permission_handler.dart';

Future<bool> permissionStorage() async {
    bool granted = await Permission.manageExternalStorage.isGranted;
    if (!granted) {
      granted = await Permission.manageExternalStorage.request().isGranted;
    }
    return granted;
}