import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/spend_item.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Page/GroupPage/group_controller.dart';
import 'package:local_split/Router/app_pages.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class GroupView extends GetView<GroupController> {
  GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    if (GroupManager().getGroup(controller.groupkey) == null) {
      return Container(
        color: Colors.red,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme().grey,
      extendBody: true,
      appBar: AppBar(
        title: Text(GroupManager().getGroup(controller.groupkey)!.name,
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
                padding: const EdgeInsets.all(5),
                child: Obx(() {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return SpendItem(
                        data: GroupManager()
                            .getGroup(controller.groupkey)!
                            .spendData[index],
                        onModifyClick: () {
                          Get.toNamed(
                            Routes.AddSpendPage,
                            arguments: {
                              "groupKey": controller.groupkey,
                              "spendId": GroupManager()
                                  .getGroup(controller.groupkey)!
                                  .spendData[index]
                                  .key
                            },
                          );
                        },
                        onDeleteClick: () {
                          controller.removeSpendData(GroupManager()
                              .getGroup(controller.groupkey)!
                              .spendData[index]
                              .key);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemCount: GroupManager()
                        .getGroup(controller.groupkey)!
                        .spendData
                        .length,
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      child: Text("Add".tr),
                      onPressed: () {
                        Get.toNamed(
                          Routes.AddSpendPage,
                          arguments: {"groupKey": controller.groupkey},
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      child: Text("Result".tr),
                      onPressed: () {
                        Get.toNamed(
                          Routes.ResultPage,
                          arguments: {"groupKey": controller.groupkey},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
