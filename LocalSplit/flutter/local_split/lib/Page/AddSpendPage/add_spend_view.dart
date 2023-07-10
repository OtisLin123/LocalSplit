import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/Calculator/calculator.dart';
import 'package:local_split/Component/person_item.dart';
import 'package:local_split/Component/person_select_widget.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:local_split/Page/AddSpendPage/add_spend_controller.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:local_split/Theme/style_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddSpendView extends GetView<AddSpendController> {
  AddSpendView({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.data == null) {
      return Container(
        color: Colors.red,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme().grey,
      extendBody: true,
      appBar: AppBar(
        title: Text(
            controller.spendUid == null
                ? "AddSpendData".tr
                : "ModifySpendData".tr,
            style: TextStyleHelper().titleWithWhite),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("SpendName".tr,
                              style: TextStyleHelper().subTitleWithNavy),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'EnterSpendName'.tr,
                          ),
                          controller: controller.spendNameTextEditingController,
                          onChanged: (value) {
                            controller.spendName = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("PaidPerson".tr,
                              style: TextStyleHelper().subTitleWithNavy),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: Obx(() {
                            return _buildPaidPersonWidgte(context);
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("CostMoney".tr,
                              style: TextStyleHelper().subTitleWithNavy),
                        ),
                        TextField(
                          focusNode: controller.focusNode,
                          readOnly: true,
                          controller: controller.calculatorTextEditController,
                          decoration: InputDecoration(
                            hintText: 'TypeCost'.tr,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () {
                              return PersonSelectWidget(
                                selectPeople: controller.splitPeople,
                                unselectPeople: controller.getAvaliablePeople(),
                                selectOnDelect: (id) {
                                  controller.removeSplitPerson(id);
                                },
                                unselectOnClick: (id) {
                                  controller.addSplitPerson(id);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          child: Text("Confirm".tr),
                          onPressed: () {
                            controller.spendUid == null
                                ? controller.addSpendData()
                                : controller.modifySpendData();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              return Visibility(
                visible: controller.showKeyboard,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 200,
                    child: Container(
                      color: Colors.white,
                      child: Calculator(
                        calculatorController: controller.calculatorController,
                        textEditController: controller.calculatorTextEditController,
                        onDone: () {
                          controller.focusNode.unfocus();
                        },
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildPaidPersonWidgte(BuildContext context) {
    if (controller.paidPerson.name == 'UnknownPaidPerson'.tr) {
      return PersonItem(
        data: PersonData(name: "SelectPaidPerson".tr, key: "unknown"),
        showDelete: false,
        onClick: (key) {
          _showDialog(context);
        },
      );
    } else {
      return PersonItem(
        data: controller.paidPerson,
        showDelete: false,
        onClick: (key) {
          _showDialog(context);
        },
      );
    }
  }

  void _showDialog(BuildContext context) {
    controller.data!.people;
    controller.person = controller.data!.people.first;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text("Cancel".tr),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text("Select".tr),
                    onPressed: () {
                      controller.addPaidPerson();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: kItemExtent,
                  onSelectedItemChanged: (int selectedItem) {
                    if (selectedItem < 0 &&
                        selectedItem >= controller.data!.people.length) {
                      return;
                    }
                    controller.person = controller.data!.people[selectedItem];
                  },
                  children: List<Widget>.generate(
                    controller.data!.people.length,
                    (int index) {
                      return Center(
                        child: Text(
                          controller.data!.people[index].name,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
