import 'package:admin/Data/Models/admin_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AdminController extends GetxController {
  RxInt adminCurrentPage = 0.obs;
  RxInt adminRowsPerPage = 10.obs;
  List<DataRow> adminDataRowList = [];
  RxList<AdminModel> adminDataList = <AdminModel>[].obs;
  RxInt adminCurrentSortColumn = 0.obs;
  RxBool adminIsAscending = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  TextEditingController adminUsernameController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  onInit() {
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
    });
    isLoading.value = LoadingUtils(false);
  }

  addAdminData({String? selectedQA}) async {
    // isLoading.value = LoadingUtils(true);
    try {
      String id = '';
      if (selectedQA == null) {
        id = const Uuid().v1();
      } else {
        id = selectedQA;
      }

      print(id);

      AdminModel adminData = AdminModel(
          username: adminUsernameController.text,
          password: adminPasswordController.text,
          aid: id);
      await _firestore.collection('Admins').doc(id).set(
            adminData.toJson(),
          );
      SnackBars.successSnackBar(content: 'Admin Added Successfully.');
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      // throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    } finally {
      // isLoading.value = LoadingUtils(false);
    }
  }

  deleteAdminData(String? qid) async {
    // isLoading.value = LoadingUtils(true);
    try {
      await _firestore.collection('Admins').doc(qid).delete();
      SnackBars.successSnackBar(content: 'Admin Deleted Successfully.');
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      // throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    } finally {
      // isLoading.value = LoadingUtils(false);
    }
  }
}
