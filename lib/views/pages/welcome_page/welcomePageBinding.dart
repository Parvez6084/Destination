
import 'package:destination/controller/auth_controller.dart';
import 'package:get/get.dart';

import 'welcomePageController.dart';

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}


