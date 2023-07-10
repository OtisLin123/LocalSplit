import 'dart:convert';
import 'dart:io';

import 'package:local_split/Model/person_data.dart';
import 'package:local_split/Model/people_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class PersonManager extends GetxController {
  static final PersonManager _singleton = PersonManager._internal();

  final RxList<PersonData> _people = <PersonData>[].obs;

  List<PersonData> get people => _people;
  set people(List<PersonData> datas) => _people.value = datas;
  
  void init() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/local_split_people.json');
    bool exist = await file.exists();
    if (exist) {
      var json = jsonDecode(await file.readAsString());
      people = List<PersonData>.from(json["people"].map((x) => PersonData.fromJson(x)));
    }
  }

  Future<void> save() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/local_split_people.json');
    Map<String, dynamic> json = {
      "people": List<dynamic>.from(people.map((x) => x.toJson())),
    };
    await file.writeAsString(jsonEncode(json));
  }


  void addPerson(PersonData person) {
    _people.add(person);
    save();
  }

  void removePerson(String id) {
    for (int i = 0; i < _people.length; i++) {
      if (_people[i].key == id) {
        _people.removeAt(i);
      }
    }
    save();
  }

  String getPersonName(String id) {
    for (PersonData person in _people) {
      if (person.key == id) {
        return person.name;
      }
    }
    return "";
  }

  factory PersonManager() {
    return _singleton;
  }

  PersonManager._internal();
}
