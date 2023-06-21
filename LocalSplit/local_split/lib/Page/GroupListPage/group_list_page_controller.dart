import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:local_split/Helper/permission_helper.dart';
import 'package:local_split/Model/group_data.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class GroupListController extends GetxController {
  RxList<GroupData> _datas = <GroupData>[].obs;

  List<GroupData> get datas => _datas.value;
  set datas(List<GroupData> datas) => _datas.value = datas;

  void setData(GroupData data) {
    for (GroupData _data in _datas) {
      if (_data.key == data.key) {
        _data = data;
      }
    }
  }

  GroupData? getData(String key) {
    for (GroupData _data in _datas) {
      if (_data.key == key) {
        return _data;
      }
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
