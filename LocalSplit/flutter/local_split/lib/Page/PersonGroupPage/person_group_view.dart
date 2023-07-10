import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/person_item.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Manager/person_manager.dart';
import 'package:local_split/Page/PersonGroupPage/person_group_controller.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonGroupView extends GetView<PersonGroupController> {
  PersonGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme().grey,
      extendBody: true,
      appBar: AppBar(
        title: Text("PeopleManger".tr, style: TextStyleHelper().titleWithWhite),
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: controller.addTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'EnterPersonName'.tr,
                            ),
                            onChanged: (value) {
                              controller.newPersonName = value;
                            },
                          ),
                        ),
                        ElevatedButton(
                          child: Text("AddPerson".tr),
                          onPressed: () {
                            controller.addPerson();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () {
                          return ListView.separated(
                            itemCount: PersonManager().people.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 40,
                                child: PersonItem(
                                  showDelete: true,
                                  data: PersonManager().people[index],
                                  onClick: (key) {},
                                  onDeleteClick: (key) {
                                    PersonManager().removePerson(key);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
