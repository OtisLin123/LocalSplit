import 'package:get/get.dart';
import 'package:local_split/Page/AddSpendPage/add_spend_bindings.dart';
import 'package:local_split/Page/AddSpendPage/add_spend_view.dart';
import 'package:local_split/Page/CreateGroupPage/create_group_bindings.dart';
import 'package:local_split/Page/CreateGroupPage/create_group_view.dart';
import 'package:local_split/Page/GroupListPage/group_list_page.dart';
import 'package:local_split/Page/GroupListPage/group_list_page_binding.dart';
import 'package:local_split/Page/GroupPage/group_bindings.dart';
import 'package:local_split/Page/GroupPage/group_view.dart';
import 'package:local_split/Page/PersonGroupPage/person_group_bindings.dart';
import 'package:local_split/Page/PersonGroupPage/person_group_view.dart';
import 'package:local_split/Page/ResultPage/result_bindings.dart';
import 'package:local_split/Page/ResultPage/result_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const Initial = Routes.GroupListPage;

  static final routes = [
    GetPage(
      name: _Paths.GroupListPage,
      page: () => GroupListView(),
      binding: GroupListBindings(),
    ),
    GetPage(
      name: _Paths.CreateGroupPage,
      page: () => CreateGroupView(),
      binding: CreateGroupBindings(),
    ),
    GetPage(
      name: _Paths.GroupPage,
      page: () => GroupView(),
      binding: GroupBindings(),
    ),
    GetPage(
      name: _Paths.AddSpendPage,
      page: () => AddSpendView(),
      binding: AddSpendBindings(),
    ),
    GetPage(
      name: _Paths.ResultPage,
      page: () => ResultView(),
      binding: ResultBindings(),
    ),
    GetPage(
      name: _Paths.ResultPage,
      page: () => ResultView(),
      binding: ResultBindings(),
    ),
    GetPage(
      name: _Paths.PersonGroupPage,
      page: () => PersonGroupView(),
      binding: PersonGroupBindings(),
    ),
  ];
}
