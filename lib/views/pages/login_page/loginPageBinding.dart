
import 'package:destination/controller/auth_controller.dart';
import 'package:get/get.dart';

import 'loginPageController.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(() => LoginPageController());
  }
}
