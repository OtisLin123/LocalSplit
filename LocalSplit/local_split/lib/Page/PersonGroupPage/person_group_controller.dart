import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_split/Manager/person_manager.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:uuid/uuid.dart';

class PersonGroupController extends GetxController {
  Rx<String> _newPersonName = "".obs;
  set newPersonName(String name) => _newPersonName.value = name;
  String get newPersonName => _newPersonName.value;

  TextEditingController addTextEditingController = TextEditingController();

  @override
  void onReady() {
    ///-implement you code-///
    super.onReady();
  }

  @override
  void onInit() {
    ///-implement you code-///
    super.onInit();
  }

  void addPerson() {
    if (newPersonName.isEmpty) {
      return;
    }
    PersonManager().addPerson(
      PersonData(
        name: newPersonName,
        key: Uuid().v4(),
      ),
    );
    addTextEditingController.text = '';
  }
}
