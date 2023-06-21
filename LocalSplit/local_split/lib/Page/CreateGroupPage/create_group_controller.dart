import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Manager/person_manager.dart';
import 'package:local_split/Model/group_data.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:uuid/uuid.dart';

class CreateGroupController extends GetxController {
  late String groupKey;

  TextEditingController groupNameController = TextEditingController();

  final Rx<String> _name = ''.obs;
  set name(String text) => _name.value = text;
  String get name => _name.value;

  final Rx<DateTime> _date = DateTime.now().obs;
  set date(DateTime date) => _date.value = date;
  DateTime get date => _date.value;

  final Rx<PersonData?> _person =
      PersonData(name: "unknown", key: 'unknown').obs;
  set person(PersonData data) => _person.value = data;
  PersonData get person => _person.value!;

  final RxList<PersonData> _people = <PersonData>[].obs;
  set people(List<PersonData> data) => _people.value = data;
  List<PersonData> get people => _people.value;

  void addPerson(String id) {
    List<PersonData> temp = [];
    for (PersonData data in people) {
      temp.add(data);
    }
    bool isFind = false;
    for (PersonData managerPerson in PersonManager().people) {
      if (managerPerson.key == id) {
        isFind = true;
        temp.add(managerPerson);
      }
    }
    if (!isFind) {
      return;
    }
    people = temp;
  }

  void removePerson(String key) {
    List<PersonData> temp = [];
    for (PersonData data in people) {
      if (data.key != key) {
        temp.add(data);
      }
    }
    people = temp;
  }

  List<PersonData> getAvaliablePeople() {
    List<PersonData> temp = [];
    for (PersonData managerData in PersonManager().people) {
      bool isFind = false;
      for (PersonData data in people) {
        if (data.key == managerData.key) {
          isFind = true;
        }
      }
      if (!isFind) {
        temp.add(managerData);
      }
    }
    return temp;
  }

  void addGroup() {
    String tempName = 'unknown';
    if (name.isNotEmpty) {
      tempName = name;
    }
    GroupManager().addGroup(GroupData(
      name: tempName,
      date: DateTime.now(),
      key: groupKey.isEmpty ? Uuid().v4() : groupKey,
      people: people,
      spendData: groupKey.isEmpty ? [] : GroupManager().getGroup(groupKey)!.spendData,
    ));
  }

  @override
  void onReady() {
    ///-implement you code-///
    super.onReady();
  }

  @override
  void onInit() {
    groupKey = Get.arguments["groupKey"];
    if (!groupKey.isEmpty && GroupManager().getGroup(groupKey) != null) {
      name = GroupManager().getGroup(groupKey)!.name;
      date = GroupManager().getGroup(groupKey)!.date;
      people = GroupManager().getGroup(groupKey)!.people;
    }
    groupNameController.text = name;
    super.onInit();
  }
}
