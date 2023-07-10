import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_split/Component/result_item.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Manager/person_manager.dart';
import 'package:local_split/Page/ResultPage/result_controller.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_split/Theme/style_theme.dart';

class ResultView extends GetView<ResultController> {
  ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme().grey,
      extendBody: true,
      appBar: AppBar(
        title: Text("Result".tr, style: TextStyleHelper().titleWithWhite),
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
            const SizedBox(height: 20,),
            Text(
              "${"ActivityName".tr} : ${GroupManager().getGroup(controller.groupkey)!.name}",
              style: TextStyleHelper().subTitleWithNavy,
            ),
            const SizedBox(height: 20,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Obx(() {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: kItemExtent,
                          child: ResultItem(
                            creditor: PersonManager().getPersonName(
                                controller.result[index].creditor),
                            debtor: PersonManager()
                                .getPersonName(controller.result[index].debtor),
                            cost: controller.result[index].cost,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: controller.result.length);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
