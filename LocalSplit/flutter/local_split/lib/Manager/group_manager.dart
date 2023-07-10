import 'dart:convert';
import 'dart:io';

import 'package:local_split/Model/group_data.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class GroupManager extends GetxController {
  static final GroupManager _singleton = GroupManager._internal();

  final RxList<GroupData> _group = <GroupData>[].obs;
  List<GroupData> get group => _group;
  set group(List<GroupData> datas) => _group.value = datas;

  void init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/local_split_group_datas.json');
    bool exist = await file.exists();
    if (exist) {
      var json = jsonDecode(await file.readAsString());
      group = List<GroupData>.from(
          json["groupsData"].map((x) => GroupData.fromJson(x)));
    }
  }

  Future<void> save() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/local_split_group_datas.json');
    // bool exist = await file.exists();
    Map<String, dynamic> json = {
      "groupsData": List<dynamic>.from(group.map((x) => x.toJson())),
    };
    await file.writeAsString(jsonEncode(json));
  }

  void addGroup(GroupData newGroup) {
    for (int i = 0; i < group.length; i++) {
      if (group[i].key == newGroup.key) {
        group[i] = newGroup;
        _group.refresh();
        save();
        return;
      }
    }
    group = [...group, newGroup];
    save();
  }

  void removeGroup(String key) {
    for (int i = 0; i < _group.length; i++) {
      if (_group[i].key == key) {
        _group.removeAt(i);
      }
    }
    save();
  }

  GroupData? getGroup(String groupKey) {
    for (GroupData data in group) {
      if (data.key == groupKey) {
        return data;
      }
    }
    return null;
  }

  factory GroupManager() {
    return _singleton;
  }

  GroupManager._internal() {}
}
