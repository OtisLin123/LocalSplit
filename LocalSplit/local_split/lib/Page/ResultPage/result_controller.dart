import 'package:get/get.dart';
import 'package:local_split/Helper/account_calculation.dart';
import 'package:local_split/Manager/group_manager.dart';

class ResultController extends GetxController {
  late String groupkey;
  final RxList<AccountDetail> _result = <AccountDetail>[].obs;
  List<AccountDetail> get result => _result.value;
  set result(List<AccountDetail> datas) => _result.value = datas;

  @override
  void onReady() {
    result = AccountCalculation().calculation(GroupManager().getGroup(groupkey)!.spendData);
    super.onReady();
  }

  @override
  void onInit() {
    groupkey = Get.arguments['groupKey'];
    super.onInit();
  }
}
