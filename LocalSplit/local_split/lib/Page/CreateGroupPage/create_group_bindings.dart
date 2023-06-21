import 'package:get/get.dart';
import 'package:local_split/Page/CreateGroupPage/create_group_controller.dart';

class CreateGroupBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<CreateGroupController>(
      () => CreateGroupController(),
    );
  }
  
}
