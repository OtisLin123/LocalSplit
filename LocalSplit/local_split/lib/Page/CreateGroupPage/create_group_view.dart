import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/person_select_widget.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Page/CreateGroupPage/create_group_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateGroupView extends GetView<CreateGroupController> {
  CreateGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme().grey,
      extendBody: true,
      appBar: AppBar(
        title: Text(
            controller.groupKey.isEmpty
                ? "CreateActivity".tr
                : "ModifyActivity".tr,
            style: TextStyleHelper().titleWithWhite),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'EnterActivityName'.tr,
                      ),
                      controller: controller.groupNameController,
                      onChanged: (value) {
                        controller.name = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () {
                          return PersonSelectWidget(
                            selectPeople: controller.people,
                            unselectPeople: controller.getAvaliablePeople(),
                            selectOnDelect: (id) {
                              controller.removePerson(id);
                            },
                            unselectOnClick: (id) {
                              controller.addPerson(id);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text("Confirm".tr),
              onPressed: () {
                controller.addGroup();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showNotAvaliablePeopleToast() {
    Fluttertoast.showToast(
        msg: "NotHaveActivityPeople".tr,
        toastLength: Toast.LENGTH_SHORT, //duration
        gravity: ToastGravity.CENTER, //location
        timeInSecForIosWeb: 1,
        backgroundColor: ColorTheme().darkGrey05, //background color
        textColor: Colors.white, //text Color
        fontSize: 16.0 //font size
        );
  }
}
