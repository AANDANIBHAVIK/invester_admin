import 'package:admin/Data/Models/category_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxInt categoryCurrentPage = 0.obs;
  RxInt categoryRowsPerPage = 10.obs;
  List<DataRow> categoryDataRowList = [];
  RxList<String> categoryDataList = <String>[].obs;
  RxInt categoryCurrentSortColumn = 0.obs;
  RxBool categoryIsAscending = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  TextEditingController categoryNameController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  onInit() {
    getCategoryData();
    super.onInit();
  }

  getCategoryData() async {
    isLoading.value = LoadingUtils(true);
    categoryDataList.clear();
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection('Categories').doc('categoryID').get();

    categoryDataList.value =
        await CategoryModel.fromJson(doc.data()!).categories ?? [];
    isLoading.value = LoadingUtils(false);
  }

  addCategoryData(String? name, {bool isDelete = false}) async {
    isLoading.value = LoadingUtils(true);
    if (name != null) {
      categoryDataList.remove(name);
    }
    if (!isDelete) {
      categoryDataList.add(categoryNameController.text);
    }
    try {
      CategoryModel categoryData = CategoryModel(categories: categoryDataList);
      await _firestore.collection('Categories').doc('categoryID').update(
            categoryData.toJson(),
          );
      SnackBars.successSnackBar(content: 'Category Added Successfully.');
      getCategoryData();
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      // throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    } finally {
      isLoading.value = LoadingUtils(false);
    }
  }
}
