import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/group_item.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Model/group_data.dart';
import 'package:local_split/Page/GroupListPage/group_list_page_controller.dart';
import 'package:local_split/Router/app_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupListView extends GetView<GroupListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activities".tr, style: TextStyleHelper().titleWithWhite),
        actions: [
          IconButton(
          icon: const Icon(FontAwesomeIcons.person),
          onPressed: () {
            Get.toNamed(Routes.PersonGroupPage);
          },
        ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Obx(() {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    children: [
                      for (GroupData data in GroupManager().group)
                        GroupItem(
                          title: data.name,
                          groupKey: data.key,
                          onClick: (key) {
                            Get.toNamed(Routes.GroupPage, arguments: {
                              "groupKey": data.key,
                            });
                          },
                          onModifyClick: (key) {
                            Get.toNamed(
                              Routes.CreateGroupPage,
                              arguments: {
                                "groupKey": data.key,
                              },
                            );
                          },
                        ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text("CreateActivity".tr),
              onPressed: () {
                Get.toNamed(Routes.CreateGroupPage, arguments: {
                  "groupKey": '',
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
