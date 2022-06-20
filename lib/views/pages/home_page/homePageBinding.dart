
import 'package:get/get.dart';

import 'homePageController.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(HomePageController());

  }
}
