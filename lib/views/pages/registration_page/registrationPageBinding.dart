
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import 'registrationPageController.dart';

class RegistrationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationPageController>(() => RegistrationPageController());
  }
}
