import 'package:get/get.dart';
import 'package:local_split/Page/ResultPage/result_controller.dart';

class ResultBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(
      () => ResultController(),
    );
  }
  
}
