import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/Calculator/calculator_controller.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Model/group_data.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:local_split/Model/spend_data.dart';
import 'package:uuid/uuid.dart';

class AddSpendController extends GetxController {
  late GroupData? data;
  late String? spendUid;

  FocusNode focusNode = FocusNode();
  TextEditingController spendNameTextEditingController =
      TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  TextEditingController calculatorTextEditController = TextEditingController();
  CalculatorController calculatorController = CalculatorController();

  final Rx<PersonData> _paidPerson =
      PersonData(name: 'UnknownPaidPerson'.tr, key: 'unknown').obs;
  PersonData get paidPerson => _paidPerson.value;
  set paidPerson(PersonData data) => _paidPerson.value = data;

  final Rx<double> _cost = 0.0.obs;
  double get cost => _cost.value;
  set cost(double data) => _cost.value = data;

  final Rx<String> _spendName = "".obs;
  String get spendName => _spendName.value;
  set spendName(String data) => _spendName.value = data;

  final RxList<PersonData> _splitPeople = <PersonData>[].obs;
  List<PersonData> get splitPeople => _splitPeople.value;
  set splitPeople(List<PersonData> data) => _splitPeople.value = data;

  final Rx<PersonData> _person =
      PersonData(name: 'unknown', key: 'unknown').obs;
  PersonData get person => _person.value;
  set person(PersonData data) => _person.value = data;

  final Rx<bool> _showKeyboard = false.obs;
  bool get showKeyboard => _showKeyboard.value;
  set showKeyboard(bool value) => _showKeyboard.value = value;

  @override
  void onReady() {
    ///-implement you code-///
    super.onReady();
  }

  @override
  void onInit() {
    String groupkey = Get.arguments['groupKey'];
    spendUid = Get.arguments['spendId'];

    data = GroupManager().getGroup(groupkey);
    focusNode.addListener(() {
      showKeyboard = focusNode.hasFocus;
      if (focusNode.hasFocus) {
        textEditingController.text = (cost == 0.0) ? '' : cost.toString();
      }
    });

    if (spendUid != null && data != null) {
      for (SpendData spendData in data!.spendData) {
        if (spendData.key == spendUid) {
          spendName = spendData.spendName;
          paidPerson = spendData.paidPerson;
          splitPeople = spendData.splitPeople;
          cost = spendData.cost;
        }
      }
    }

    calculatorController.result = cost;
    calculatorTextEditController.text = calculatorController.resultString;

    calculatorTextEditController.addListener(() {
      cost = double.parse(calculatorTextEditController.text);
    });

    textEditingController.text = (cost == 0.0) ? '' : cost.toString();
    spendNameTextEditingController.text = spendName;

    super.onInit();
  }

  void addPaidPerson() {
    paidPerson = person;
  }

  void addSplitPerson(String key) {
    PersonData? selectData;
    for (PersonData data in data!.people) {
      if (key == data.key) {
        selectData = data;
      }
    }
    if (selectData == null) {
      return;
    }

    List<PersonData> temp = [];
    for (PersonData data in splitPeople) {
      temp.add(data);
    }
    temp.add(selectData);
    splitPeople = temp;
  }

  void removeSplitPerson(String key) {
    List<PersonData> temp = [];
    for (PersonData data in splitPeople) {
      if (data.key != key) {
        temp.add(data);
      }
    }
    splitPeople = temp;
  }

  List<PersonData> getAvaliablePeople() {
    List<PersonData> temp = [];
    for (PersonData managerData in data!.people) {
      bool isFind = false;
      for (PersonData data in splitPeople) {
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

  void addSpendData() {
    data!.addSpendData(SpendData(
      spendName: spendName == "" ? "UnknownName".tr : spendName,
      key: Uuid().v4(),
      cost: cost,
      date: DateTime.now(),
      paidPerson: paidPerson,
      splitPeople: splitPeople,
    ));
    GroupManager().addGroup(data!);
  }

  void modifySpendData() {
    data!.addSpendData(SpendData(
      spendName: spendName,
      key: spendUid ?? Uuid().v4(),
      cost: cost,
      date: DateTime.now(),
      paidPerson: paidPerson,
      splitPeople: splitPeople,
    ));
    GroupManager().addGroup(data!);
  }
}
