import 'package:admin/Data/Models/admin_model.dart';
import 'package:admin/Routes/routes.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  RxList<AdminModel> adminDataList = <AdminModel>[].obs;

  TextEditingController adminUsernameController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  RxBool loginEmail = false.obs;
  RxBool isUserValid = false.obs;

  @override
  onInit() async {
    getAdminData();
    super.onInit();
  }

  getAdminData() async {
    isLoading.value = LoadingUtils(true);
    await _firestore.collection('Admins').snapshots().listen((event) {
      adminDataList.clear();
      for (var i in event.docs) {
        adminDataList.add(AdminModel.fromJson(i.data()));
      }
      print(adminDataList.value);
    });
    isLoading.value = LoadingUtils(false);
  }

  void signInUser() async {
    if (loginFormKey.currentState!.validate()) {
      isLoading.value = LoadingUtils(true);
      for (var i in adminDataList) {
        if (i.username == adminUsernameController.text.trim() &&
            i.password == adminPasswordController.text) {
          Get.offAllNamed(Routes.mainScreen);
          isUserValid.value = true;
          GetStorage().write('loginEmail', i.username);
        } else {
          print('nononononono');
        }
      }
      if (isUserValid.value) {
        SnackBars.successSnackBar(content: 'Login SuccessFully');
      } else {
        SnackBars.errorSnackBar(content: 'Invalid Password or Username');
      }
      isLoading.value = LoadingUtils(false);
    }
  }
}
