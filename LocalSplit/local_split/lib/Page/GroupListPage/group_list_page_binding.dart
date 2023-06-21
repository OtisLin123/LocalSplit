import 'package:get/get.dart';
import 'package:local_split/Page/GroupListPage/group_list_page_controller.dart';

class GroupListBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<GroupListController>(
    //   () => GroupListController(),
    // );

    Get.put<GroupListController>(
      GroupListController(),
    );
  }
}
