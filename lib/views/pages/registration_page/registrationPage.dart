
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../consts/app_const.dart';
import '../../widgets/textField_widget.dart';
import 'registrationPageController.dart';

class RegistrationPage extends GetView<RegistrationPageController> {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Obx((){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('LOGO',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                        const SizedBox(height: 20),
                        TextFieldWidget(
                          controller: controller.firstNameController,
                          keyboardType: TextInputType.text,
                          label: 'First Name',
                          obscureText: false,
                          onChanged: (value) {controller.registration.value.firstName = value;},
                        ),
                        TextFieldWidget(
                          controller: controller.lastNameController,
                          keyboardType: TextInputType.text,
                          label: 'Last Name',
                          obscureText: false,
                          onChanged: (value) {controller.registration.value.lastName = value;},
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextFieldWidget(
                                controller: controller.emailController,
                                keyboardType: TextInputType.text,
                                label: 'Email',
                                obscureText: false,
                                onChanged: (value) {controller.registration.value.email = value;},
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin:const EdgeInsets.only(top: 12,left: 8),
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white10,
                                      textStyle:
                                      const TextStyle(fontWeight: FontWeight.bold)),
                                  child: const Text('Send Code'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFieldWidget(
                          controller: controller.validationCodeController,
                          keyboardType: TextInputType.text,
                          label: 'Validation Code',
                          obscureText: false,
                          onChanged: (value) {controller.registration.value.otpCode = value;},
                        ),
                        TextFieldWidget(
                          controller: controller.userNameController,
                          keyboardType: TextInputType.text,
                          label: 'User Name',
                          obscureText: false,
                          onChanged: (value) {controller.registration.value.userName = value;},
                        ),
                        TextFieldWidget(
                          controller: controller.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          obscureText: true,
                          onChanged: (value) {
                            controller.registration.value.password = value;
                          },
                        ),
                        TextFieldWidget(
                          controller: controller.rePasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'RePassword',
                          obscureText: true,
                          onChanged: (value) {
                            controller.registration.value.rePassword = value;
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Checkbox(
                                value: controller.checked.value,
                                onChanged: (value) {
                                  controller.checked.value = value!;
                                },
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'I Agree ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            const SizedBox(
                                height: 80,
                                width: 250,
                                child: Text(
                                  AppConst.trams,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white24),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if(controller.checked.value){
                              if(controller.registration.value.password == controller.registration.value.rePassword){
                                controller.saveRegistrationData(context);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Password and RePassword Not Match'),
                                  backgroundColor: Colors.red,
                                )) ;
                              }}else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Check the agree button'),
                                  backgroundColor: Colors.red,
                                )) ;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white10,
                                textStyle:
                                const TextStyle(fontWeight: FontWeight.bold)),
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    );
                  })
              ),
            ),
          ),
        )
      ),
    );
  }

}




