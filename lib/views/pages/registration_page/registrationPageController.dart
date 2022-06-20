
import 'package:destination/model/registration_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';


class RegistrationPageController extends GetxController{

  var checked = false.obs;
  var registration = RegistrationModel().obs;

  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController validationCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  void saveRegistrationData(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('user = ${registration.toString()} ');
      AuthController.instance.registration(registration.value);
    }
  }




  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    validationCodeController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}