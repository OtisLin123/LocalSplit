import 'package:get/get.dart';
import 'package:local_split/Manager/group_manager.dart';
import 'package:local_split/Model/group_data.dart';

class GroupController extends GetxController {
  late GroupData? data;
  late String groupkey;

  @override
  void onReady() {
    ///-implement you code-///
    super.onReady();
  }

  @override
  void onInit() {
    groupkey = Get.arguments['groupKey'];
    data = GroupManager().getGroup(groupkey);
    super.onInit();
  }

  void removeSpendData(String spendDataKey) {
    data!.removeSpendData(spendDataKey);
    GroupManager().addGroup(data!);
  }
}
