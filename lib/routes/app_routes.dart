


import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_verify_link/pages/tab_page/view/tab_view.dart';
import 'package:task_verify_link/routes/routes_name.dart';

import '../pages/tab_page/controller/tab_controller.dart';

class AppRoutes {

  static const initialRoute = RoutesName.tabScreen;

  static final appRoutes = [
    GetPage(
      name: RoutesName.tabScreen,
      page: () => TabView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TabViewController>(() => TabViewController());
      }),
    ),
  ];
}

