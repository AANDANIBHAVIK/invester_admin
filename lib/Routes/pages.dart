import 'package:admin/screens/LoginPage/login_binding.dart';
import 'package:admin/screens/LoginPage/login_screen.dart';
import 'package:admin/screens/main/main_binding.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:get/get.dart' show GetPage, Transition;

import 'routes.dart';

const Transition transition = Transition.native;

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.loginScreen;

  static final routes = [
    GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
        transition: Transition.fadeIn),
    // GetPage(
    //     name: Routes.registerScreen,
    //     page: () => const SignUpScreen(),
    //     binding: SignUpBinding(),
    //     transition: Transition.cupertino),

    GetPage(
        name: Routes.mainScreen,
        binding: MainBinding(),
        page: () => MainScreen(),
        transition: Transition.fadeIn),
  ];
}
