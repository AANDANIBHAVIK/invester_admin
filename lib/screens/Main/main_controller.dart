import 'package:admin/Routes/routes.dart';
import 'package:admin/screens/Admins/admin_screen.dart';
import 'package:admin/screens/Category/category_screen.dart';
import 'package:admin/screens/CompanyPage/company_main_screen.dart';
import 'package:admin/screens/Documents/documents_screen.dart';
import 'package:admin/screens/EnterpriseUser/enterprise_main_screen.dart';
import 'package:admin/screens/FaQ/faq_screen.dart';
import 'package:admin/screens/IndividualUser/users_main_screen.dart';
import 'package:admin/screens/PropertyPage/property_main_screen.dart';
import 'package:admin/screens/Settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> sidebarWidgetsList = [
    UsersMainScreen(),
    EnterpriseMainScreen(),
    CompanyMainScreen(),
    PropertyMainScreen(),
    CategoryScreen(),
    FaqScreen(),
    DocumentScreen(),
    SettingScreen(),
    AdminScreen(),
  ];

  List<String> SidebarNameList = [
    'Individual Users',
    'Enterprise Users',
    'Companies',
    'Property',
    'Categories',
    'FAQs',
    'Documents',
    'Settings',
    'Admins',
    'Logout',
  ];

  RxInt selectedWidget = 0.obs;
  RxString loginEmail = ''.obs;

  void controlMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    loginEmail.value = await GetStorage().read('loginEmail') ?? '';
    print('-----------------');
    print(loginEmail.value);
    print('-----------------');
    if (loginEmail.value.isEmpty) {
      Get.offAllNamed(Routes.loginScreen);
    }
    super.onInit();
  }
}
