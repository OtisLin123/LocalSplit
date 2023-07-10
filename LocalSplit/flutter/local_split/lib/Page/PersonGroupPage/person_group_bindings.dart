import 'package:get/get.dart';
import 'package:local_split/Page/PersonGroupPage/person_group_controller.dart';

class PersonGroupBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<PersonGroupController>(
      () => PersonGroupController(),
    );
  }
  
}
