
import 'package:destination/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController{

  var userName = ''.obs;
  var password =''.obs;

  var checked = false.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();





  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void saveLoginData(BuildContext context) {
    if (userName.value.isNotEmpty && password.value.isNotEmpty ) {
      print('user = ${userName.value}, ${password.value} ');
      AuthController.instance.login(userName.value, password.value);
    }
  }

}