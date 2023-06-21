import 'package:get/get.dart';
import 'package:local_split/Page/GroupPage/group_controller.dart';

class GroupBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<GroupController>(
      () => GroupController(),
    );
  }
  
}
