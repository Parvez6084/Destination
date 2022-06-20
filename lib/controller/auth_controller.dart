import 'dart:async';

import 'package:destination/model/registration_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthController extends GetxController{

    static AuthController instance = Get.find();
    late Rx<User?> _user;
    FirebaseAuth auth = FirebaseAuth.instance;

    @override
  void onReady() {
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user){
    Future.delayed(const Duration(seconds: 3),(){
        if(user == null) {
        Get.offAllNamed(Routes.loginPage);
        } else {
        Get.offAllNamed(Routes.homePage);
        }
    });
  }

  void registration(RegistrationModel registration)async{
      try{
       await auth.createUserWithEmailAndPassword(email: registration.email!, password: registration.password!);
      }catch(e){
        Get.snackbar('registration', 'registration message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Account creating fail',style: TextStyle(color: Colors.white),)  ,
          messageText:Text(e.toString(),style: const TextStyle(color: Colors.white),));
      }
  }


  void login(String email, String password)async{
      try{
       await auth.signInWithEmailAndPassword(email: email, password: password);
      }catch(e){
        Get.snackbar('login', 'login message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Login fail',style: TextStyle(color: Colors.white),)  ,
          messageText:Text(e.toString(),style: const TextStyle(color: Colors.white),)
    );
      }
  }

  void logOut () async{
    await auth.signOut();
    }



}