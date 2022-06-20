import 'package:destination/views/pages/login_page/loginPage.dart';
import 'package:destination/views/pages/login_page/loginPageBinding.dart';
import 'package:destination/views/pages/registration_page/registrationPage.dart';
import 'package:destination/views/pages/registration_page/registrationPageBinding.dart';
import 'package:get/get.dart';

import '../views/pages/home_page/homePage.dart';
import '../views/pages/home_page/homePageBinding.dart';
import '../views/pages/welcome_page/welcomePage.dart';
import '../views/pages/welcome_page/welcomePageBinding.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.welcomePage;
  static final routes = [
    GetPage(
      name: Routes.welcomePage,
      page: () => WelcomePage(),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: Routes.homePage,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: Routes.registrationPage,
      page: () => RegistrationPage(),
      binding: RegistrationPageBinding(),
    ),
    GetPage(
      name: Routes.loginPage,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
    ),
  ];
}
