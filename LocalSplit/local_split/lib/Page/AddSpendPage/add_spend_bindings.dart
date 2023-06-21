import 'package:get/get.dart';
import 'package:local_split/Page/AddSpendPage/add_spend_controller.dart';

class AddSpendBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<AddSpendController>(
      () => AddSpendController(),
    );
  }
}
