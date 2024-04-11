import 'package:admin/Data/Models/companies_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'company_details_screen.dart';
import 'company_list_screen.dart';

class CompanyController extends GetxController {
  // USERS DATA TABLE LIST

  RxInt companyCurrentPage = 0.obs;
  RxInt companyRowsPerPage = 10.obs;
  List<DataRow> companyDataRowList = [];
  RxList<CompaniesModel> companyDataList = <CompaniesModel>[].obs;
  RxInt companyCurrentSortColumn = 0.obs;
  RxBool companyIsAscending = true.obs;

  RxString selectedCompanyId = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  List companyScreenList = [companyListScreen(), CompanyDetailsScreen()];
  RxInt currentSelectedScreen = 0.obs;

  RxBool isLoading = false.obs;

  // :::::::::::::::: COMPANY DETAILS VARIABLES ::::::::::::

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController foundedYearController = TextEditingController();
  TextEditingController sizeCompanyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController numOfEmpController = TextEditingController();

  // :::::::::::::::::::::: END ::::::::::::::::::::::::::::

  @override
  void onInit() {
    getCompanyDetails();
    super.onInit();
  }

  getCompanyDetails() async {
    // Stream<QuerySnapshot<Map<String, dynamic>>> snap =

    await _firestore.collection('Companies').snapshots().listen((event) {
      companyDataList.clear();
      for (var i in event.docs) {
        companyDataList.add(CompaniesModel.fromJson(i.data()));
      }
    });
  }

  getSelectedCompanyDetails(String cid) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('Companies').doc(cid).get();
    Map<String, dynamic> dataMap = snap.data() as Map<String, dynamic>;
    return CompaniesModel.fromJson(dataMap);
  }

  void getSelectedCompanyData() async {
    isLoading.value = LoadingUtils(true);
    try {
      CompaniesModel companyData =
          await getSelectedCompanyDetails(selectedCompanyId.value);

      nameController.text = companyData.name ?? '';
      ownerController.text = companyData.owner ?? '';
      typeController.text = companyData.type ?? '';
      foundedYearController.text = companyData.foundedYear ?? '';

      sizeCompanyController.text = companyData.sizeOfCompany ?? '';

      locationController.text = companyData.location ?? '';

      websiteController.text = companyData.website ?? '';
      numOfEmpController.text = companyData.numOfEmp ?? '';
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    }
    isLoading.value = LoadingUtils(false);
  }

  Future setSelectedCompanyData() async {
    isLoading.value = LoadingUtils(true);
    if (checkValid()) {
      String id = '';
      if (selectedCompanyId.value == '') {
        id = const Uuid().v1();
      } else {
        id = selectedCompanyId.value;
      }
      try {
        CompaniesModel companyData = CompaniesModel(
          name: nameController.text,
          owner: ownerController.text,
          type: typeController.text,
          foundedYear: foundedYearController.text,
          location: locationController.text,
          website: websiteController.text,
          sizeOfCompany: sizeCompanyController.text,
          numOfEmp: numOfEmpController.text,
          cid: id,
        );
        await _firestore.collection('Companies').doc(id).set(
              companyData.toJson(),
              SetOptions(merge: true),
            );
        onBack();
        SnackBars.successSnackBar(content: 'Company Setup Successfully.');
      } on FirebaseAuthException catch (e) {
        isLoading.value = LoadingUtils(false);
        print(e);
        SnackBars.errorSnackBar(content: e.message.toString());
        throw e;
      } catch (e) {
        SnackBars.errorSnackBar(content: e.toString());
      } finally {
        isLoading.value = LoadingUtils(false);
      }
    } else {}
    isLoading.value = LoadingUtils(false);
  }

  Future deleteCompany(
    String pid,
  ) async {
    try {
      await _firestore.collection('Companies').doc(pid).delete();

      SnackBars.successSnackBar(content: 'Company Delete Successfully.');
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    }
  }

  bool checkValid() {
    if (nameController.text.isEmpty ||
        ownerController.text.isEmpty ||
        typeController.text.isEmpty ||
        foundedYearController.text.isEmpty ||
        sizeCompanyController.text.isEmpty ||
        locationController.text.isEmpty ||
        websiteController.text.isEmpty ||
        numOfEmpController.text.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please Fill all Values');
      return false;
    } else {
      return true;
    }
  }

  void onBack() async {
    currentSelectedScreen.value = 0;

    //  ::::::::::::::::::: Clear all Data ::::::::::::::::::::::::::::::::::

    nameController.text = '';
    typeController.text = '';
    ownerController.text = '';
    foundedYearController.text = '';

    locationController.text = '';

    websiteController.text = '';

    sizeCompanyController.text = '';
    numOfEmpController.text = '';

    // :::::::::: END ::::::::::::::::::::::::::::::::
  }

  void onCompanyDetails() {
    getCompanyDetails();
    currentSelectedScreen.value = 1;
  }

  void onCompanyAdd() {
    selectedCompanyId.value = '';
    currentSelectedScreen.value = 1;
  }
}
