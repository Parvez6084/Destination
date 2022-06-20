import 'package:destination/consts/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../widgets/textField_widget.dart';
import 'loginPageController.dart';

class LoginPage extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black54,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 40,
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
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldWidget(
                        controller: controller.userNameController,
                        keyboardType: TextInputType.text,
                        label: 'User Name',
                        obscureText: false,
                        onChanged: (value) {
                          controller.userName.value = value;
                        },
                      ),
                      TextFieldWidget(
                        controller: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'Password',
                        obscureText: true,
                        onChanged: (value) {
                          controller.password.value = value;
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
                            controller.checked.value ? controller.saveLoginData(context)
                                : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Check the agree button'),
                              backgroundColor: Colors.red,
                            )) ;
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
            Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: TextButton(
                child: const Text(
                  'Let ready to Registration >>',
                  style: TextStyle(color: Colors.pink)),
                onPressed: () {Get.toNamed(Routes.registrationPage);},
              ),
            )
          ],
        ),
      ),
    );
  }
}
