import 'dart:io';

import 'package:admin/Data/Models/category_model.dart';
import 'package:admin/Data/Models/companies_model.dart';
import 'package:admin/Data/Models/property_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Data/Resources/storage_method.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:admin/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'property_details_screen.dart';
import 'property_list_screen.dart';

class PropertyController extends GetxController {
  // USERS DATA TABLE LIST

  RxInt propertyCurrentPage = 0.obs;
  RxInt propertyRowsPerPage = 10.obs;
  List<DataRow> propertyDataRowList = [];
  RxList<PropertyModel> propertyDataList = <PropertyModel>[].obs;
  RxInt propertyCurrentSortColumn = 0.obs;
  RxBool propertyIsAscending = true.obs;

  RxString selectedPropertyId = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  List propertyScreenList = [PropertyListScreen(), PropertyDetailsScreen()];
  RxInt currentSelectedScreen = 0.obs;

  RxBool isLoading = false.obs;

  // :::::::::::::::: PROPERTY DETAILS VARIABLES ::::::::::::

  final GlobalKey<FormState> propertyFormKey = GlobalKey<FormState>();

  RxList<String> propertyImgList = <String>[].obs;
  // RxList<Uint8List> propertyImgFiles = <Uint8List>[].obs;

  RxString soldValue = ''.obs;

  RxString categorySelectedStatus = ''.obs;
  RxList<String> categoryStatus = [''].obs;

  RxString companySelectedStatus = ''.obs;
  List<CompaniesModel> companyMap = [];
  Map<String, String> companyStatus = {'': ''};

  RxString offerSelectedStatus = ''.obs;
  List<String> offerStatus = [
    '',
    currentOffer,
    futureOffer,
  ];

  RxString statusSelectedStatus = ''.obs;
  List<String> statusStatus = [
    '',
    publicStatus,
    privateStatus,
  ];

  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController propertyTitleController = TextEditingController();
  TextEditingController propertyFinalValController = TextEditingController();
  TextEditingController propertyDocController = TextEditingController();
  TextEditingController investPerMonthController = TextEditingController();
  TextEditingController bundleController = TextEditingController();
  TextEditingController uniteController = TextEditingController();
  TextEditingController investPriceController = TextEditingController();

  TextEditingController annualRentalController = TextEditingController();
  TextEditingController devCapRateController = TextEditingController();
  TextEditingController afterDevValueController = TextEditingController();

  RxString dispositionDate = Utils.dateConvertor(DateTime.now()).obs;
  TextEditingController dispositionDateController = TextEditingController();

  TextEditingController perShareController = TextEditingController();
  TextEditingController shareLeftController = TextEditingController();
  TextEditingController averagePurchaseController = TextEditingController();

  RxList<String> propertyVideoList = <String>[].obs;
  // RxList<Uint8List> propertyVideoFiles = <Uint8List>[].obs;

  TextEditingController cashFinancingUrlController = TextEditingController();
  TextEditingController cashFinancingNameController = TextEditingController();
  // RxString cashFinancingFilePath = ''.obs;
  Rx<Uint8List> cashFinancingFile = Uint8List(0).obs;

  TextEditingController propertyDetailsUrlController = TextEditingController();
  TextEditingController propertyDetailsNameController = TextEditingController();
  // RxString propertyDetailsFilePath = ''.obs;
  Rx<Uint8List> propertyDetailsFile = Uint8List(0).obs;

  TextEditingController documentsUrlController = TextEditingController();
  TextEditingController documentsNameController = TextEditingController();
  // RxString documentsFilePath = ''.obs;
  Rx<Uint8List> documentsFile = Uint8List(0).obs;

  TextEditingController afterARCController = TextEditingController();
  TextEditingController afterDevCapController = TextEditingController();
  TextEditingController projectMetricsDevValController =
      TextEditingController();

  RxString estimateDispositionDate = Utils.dateConvertor(DateTime.now()).obs;
  TextEditingController estimateDispositionDateController =
      TextEditingController();

  // :::::::::::::::::::::: END ::::::::::::::::::::::::::::

  @override
  void onInit() async {
    // if (selectedPropertyId.value.isNotEmpty) {
    // await getCategoryList();
    // }
    await getPropertiesDetails();
    await getCompanyList();
    super.onInit();
  }

  Future getCategoryList() async {
    await _firestore
        .collection('Categories')
        .doc('categoryID')
        .snapshots()
        .listen((event) async {
      categoryStatus.clear();
      categoryStatus.add('');
      List<String> _temp =
          await CategoryModel.fromJson(event.data()!).categories!;
      categoryStatus.addAll(_temp);
    });
    // categorySelectedStatus.value = categoryStatus.first;
  }

  getCompanyList() async {
    await _firestore.collection('Companies').snapshots().listen((event) async {
      List<CompaniesModel> _temp = [];

      for (var i in event.docs) {
        _temp.add(CompaniesModel.fromJson(i.data()));
      }
      companyStatus.clear();
      companyMap.addAll(_temp);
      companyStatus[''] = '';
      for (var i in companyMap) {
        companyStatus['${i.cid}'] = '${i.name}';
        // print(i.name);
      }
    });

    // print(companyStatus);
    // companySelectedStatus.value = companyStatus.keys.last;
  }

  getPropertiesDetails() async {
    // Stream<QuerySnapshot<Map<String, dynamic>>> snap =

    await _firestore.collection('Properties').snapshots().listen((event) {
      propertyDataList.clear();
      for (var i in event.docs) {
        propertyDataList.add(PropertyModel.fromJson(i.data()));
      }
    });
  }

  void getSelectedPropertyData() async {
    isLoading.value = LoadingUtils(true);
    await getCategoryList();
    try {
      PropertyModel propertyData =
          await authMethod.getPropertyDetails(selectedPropertyId.value);
      soldValue.value = propertyData.sold ?? '';
      propertyImgList.value = propertyData.image ?? [];
      print(propertyData.category);
      print(categoryStatus);
      print(categoryStatus.contains(propertyData.category));
      if (categoryStatus.contains(propertyData.category)) {
        categorySelectedStatus.value = propertyData.category ?? '';
      } else {
        categorySelectedStatus.value = '';
      }

      if (companyStatus.keys.contains(propertyData.company)) {
        companySelectedStatus.value = propertyData.company ?? '';
      } else {
        companySelectedStatus.value = '';
      }

      offerSelectedStatus.value = propertyData.offer ?? '';

      statusSelectedStatus.value = propertyData.status ?? '';
      streetController.text = propertyData.address?.street ?? '';
      cityController.text = propertyData.address?.city ?? '';
      zipCodeController.text = propertyData.address?.zipCode ?? '';
      countryController.text = propertyData.address?.country ?? '';
      propertyTitleController.text = propertyData.projectTitle ?? '';
      propertyFinalValController.text = propertyData.finalValue ?? '';
      propertyDocController.text = propertyData.projectDes ?? '';

      investPerMonthController.text = propertyData.investPerMonth ?? '';

      bundleController.text = propertyData.bundle ?? '';

      uniteController.text = propertyData.unite ?? '';
      investPriceController.text = propertyData.investmentPrice ?? '';

      annualRentalController.text =
          propertyData.marchDividends?.annualCollection ?? '';
      devCapRateController.text = propertyData.marchDividends?.devCapRate ?? '';
      afterDevValueController.text =
          propertyData.marchDividends?.afterDevValue ?? '';
      dispositionDate.value = Utils.timeStampToString(
          propertyData.marchDividends?.dispositionDate ?? Timestamp.now());
      dispositionDateController.text = Utils.timeStampToString(
          propertyData.marchDividends?.dispositionDate ?? Timestamp.now());

      perShareController.text = propertyData.aboutShare?.perShare ?? '';
      shareLeftController.text = propertyData.aboutShare?.shareLeft ?? '';
      averagePurchaseController.text =
          propertyData.aboutShare?.avgPurchase ?? '';

      propertyVideoList.value = propertyData.video ?? [];
      // addVideos(propertyData.video ?? []);
      cashFinancingUrlController.text =
          propertyData.cashFinancing?.fileUrl ?? '';
      cashFinancingNameController.text =
          propertyData.cashFinancing?.fileName ?? '';
      propertyDetailsUrlController.text =
          propertyData.propertyDetails?.fileUrl ?? '';
      propertyDetailsNameController.text =
          propertyData.propertyDetails?.fileName ?? '';
      documentsUrlController.text = propertyData.documents?.fileUrl ?? '';
      documentsNameController.text = propertyData.documents?.fileName ?? '';

      afterARCController.text = propertyData.projectMetrics?.afterDevARC ?? '';
      afterDevCapController.text =
          propertyData.projectMetrics?.afterDevCapRate ?? '';
      projectMetricsDevValController.text =
          propertyData.projectMetrics?.afterDevValue ?? '';
      estimateDispositionDate.value = Utils.timeStampToString(
          propertyData.projectMetrics?.estimatedDispositionDate ??
              Timestamp.now());
      estimateDispositionDateController.text = Utils.timeStampToString(
          propertyData.projectMetrics?.estimatedDispositionDate ??
              Timestamp.now());
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    }
    isLoading.value = LoadingUtils(false);
  }

  addVideos(List<String> list) async {
    // print("${list}::::::::-===-=-=-");
    for (var i = 0; i < list.length; i++) {
      await Future.delayed(const Duration(milliseconds: 2000), () {
        // print("${list[i]}    ::::::::-===-=-=-");
        propertyVideoList.add(list[i]);
      });
    }
  }

  Future setSelectedPropertyData() async {
    isLoading.value = LoadingUtils(true);
    if (checkValid()) {
      String id = '';
      if (selectedPropertyId.value == '') {
        id = const Uuid().v1();
      } else {
        id = selectedPropertyId.value;
      }
      // print(selectedPropertyId.value);
      // print(id);

      await uploadDocumentFirebase();

      try {
        PropertyModel propertyData = PropertyModel(
            image: propertyImgList.value,
            category: categorySelectedStatus.value,
            status: statusSelectedStatus.value,
            company: companySelectedStatus.value,
            projectTitle: propertyTitleController.text,
            finalValue: propertyFinalValController.text,
            projectDes: propertyDocController.text,
            offer: offerSelectedStatus.value,
            address: Address(
                street: streetController.text,
                city: cityController.text,
                zipCode: zipCodeController.text,
                country: countryController.text),
            investPerMonth: investPerMonthController.text,
            bundle: bundleController.text,
            unite: uniteController.text,
            investmentPrice: investPriceController.text,
            marchDividends: MarchDividends(
              annualCollection: annualRentalController.text,
              devCapRate: devCapRateController.text,
              afterDevValue: afterDevValueController.text,
              dispositionDate: Utils.stringToTimeStamp(dispositionDate.value),
            ),
            aboutShare: AboutShare(
              perShare: perShareController.text,
              shareLeft: shareLeftController.text,
              avgPurchase: averagePurchaseController.text,
            ),
            video: propertyVideoList.value,
            cashFinancing: DocumentFile(
                fileName: cashFinancingNameController.text,
                fileUrl: cashFinancingUrlController.text),
            propertyDetails: DocumentFile(
                fileName: propertyDetailsNameController.text,
                fileUrl: propertyDetailsUrlController.text),
            documents: DocumentFile(
                fileName: documentsNameController.text,
                fileUrl: documentsUrlController.text),
            projectMetrics: ProjectMetrics(
              afterDevARC: afterARCController.text,
              afterDevCapRate: afterDevCapController.text,
              afterDevValue: projectMetricsDevValController.text,
              estimatedDispositionDate:
                  Utils.stringToTimeStamp(estimateDispositionDate.value),
            ),
            pId: id);
        await _firestore.collection('Properties').doc(id).set(
              propertyData.toJson(),
              SetOptions(merge: true),
            );
        selectedPropertyId.value = id;
        await onBack();
        SnackBars.successSnackBar(content: 'Account Setup Successfully.');
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

  Future uploadImageFirebase() async {
    String? imagePath;
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result == null) {
      print("No file selected");
    } else {
      result.files.forEach((element) async {
        Uint8List? imageFile = element.bytes;
        if (imageFile == null && element.path != null) {
          imageFile = await convertXFileToUint8List(File(element.path!));
        }
        if (imageFile != null) {
          EasyLoading.show();

          var _image = await StorageMethod()
              .uploadDocumentToStorage('property/Image', imageFile);

          propertyImgList.add(_image);
          EasyLoading.dismiss();
        }
      });
    }
    ;
  }

  Future uploadVideoFirebase(String link) async {
    propertyVideoList.add(link);
  }

  Future uploadDocumentFirebase() async {
    if (cashFinancingFile.value.isNotEmpty) {
      if (cashFinancingUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(cashFinancingUrlController.text);
      }
      cashFinancingUrlController.text = await StorageMethod()
          .uploadDocumentToStorage(
              'property/Documents/CashFinance', cashFinancingFile.value);
    }
    if (propertyDetailsFile.value.isNotEmpty) {
      if (propertyDetailsUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(propertyDetailsUrlController.text);
      }
      propertyDetailsUrlController.text = await StorageMethod()
          .uploadDocumentToStorage(
              'property/Documents/PropertyDetail', propertyDetailsFile.value);
    }
    if (documentsFile.value.isNotEmpty) {
      if (documentsUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(documentsUrlController.text);
      }

      documentsUrlController.text = await StorageMethod()
          .uploadDocumentToStorage(
              'property/Documents/Documents', documentsFile.value);
    }
  }

  Future getDocumentsStorage(int fileType) async {
    // String? documentPath;
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      print("No file selected");
    } else {
      result.files.forEach((element) async {
        // documentPath = element.path;
        Uint8List? documentFile = element.bytes;
        if (documentFile == null && element.path != null) {
          documentFile = await convertXFileToUint8List(File(element.path!));
        }
        if (documentFile != null) {
          EasyLoading.show();
          if (fileType == 1) {
            cashFinancingFile.value = documentFile;
            cashFinancingNameController.text = element.name;
          } else if (fileType == 2) {
            propertyDetailsFile.value = documentFile;
            propertyDetailsNameController.text = element.name;
          } else if (fileType == 3) {
            documentsFile.value = documentFile;
            documentsNameController.text = element.name;
          }

          EasyLoading.dismiss();
        }
      });
    }
    ;
  }

  Future deletePropertyData(
      String pid,
      List<String>? images,
      List<String>? videos,
      String? documentUrl,
      String? propertyDetailsUrl,
      String? cashFinanceUrl) async {
    try {
      await _firestore.collection('Properties').doc(pid).delete();

      for (var i in images ?? []) {
        await StorageMethod().deleteDocumentToStorage(i);
      }
      for (var i in videos ?? []) {
        await StorageMethod().deleteDocumentToStorage(i);
      }

      await StorageMethod().deleteDocumentToStorage(documentUrl!);
      await StorageMethod().deleteDocumentToStorage(propertyDetailsUrl!);
      await StorageMethod().deleteDocumentToStorage(cashFinanceUrl!);

      SnackBars.successSnackBar(content: 'Property Delete Successfully.');
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    }
  }

  bool checkValid() {
    if (propertyImgList.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please Add Property Images');
      return false;
    } else if (categorySelectedStatus.value.isEmpty ||
            statusSelectedStatus.value.isEmpty ||
            streetController.text.isEmpty ||
            cityController.text.isEmpty ||
            zipCodeController.text.isEmpty ||
            countryController.text.isEmpty ||
            propertyTitleController.text.isEmpty ||
            propertyFinalValController.text.isEmpty ||
            propertyDocController.text.isEmpty ||
            investPerMonthController.text.isEmpty ||
            // bundleController.text.isEmpty ||
            uniteController.text.isEmpty ||
            investPriceController.text.isEmpty ||
            // annualRentalController.text.isEmpty ||
            // devCapRateController.text.isEmpty ||
            // afterDevValueController.text.isEmpty ||
            perShareController.text.isEmpty ||
            shareLeftController.text.isEmpty ||
            averagePurchaseController.text.isEmpty
        // afterARCController.text.isEmpty ||
        // afterDevCapController.text.isEmpty ||
        // projectMetricsDevValController.text.isEmpty
        ) {
      SnackBars.errorSnackBar(content: 'Please Fill all Values');
      return false;
    } else if (propertyVideoList.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please Add Property Videos');
      return false;
    } else {
      return true;
    }
  }

  Future onBack() async {
    currentSelectedScreen.value = 0;
    if (selectedPropertyId.value.isEmpty) {
      for (var i in propertyImgList ?? []) {
        await StorageMethod().deleteDocumentToStorage(i);
      }
      for (var i in propertyVideoList ?? []) {
        await StorageMethod().deleteDocumentToStorage(i);
      }
    }

    //  ::::::::::::::::::: Clear all Data ::::::::::::::::::::::::::::::::::

    selectedPropertyId.value = '';

    soldValue.value = '0';
    propertyImgList.value = [];

    categoryStatus.value = [''];
    categorySelectedStatus.value = categoryStatus.value.first;

    companySelectedStatus.value = companyStatus.keys.first;
    offerSelectedStatus.value = offerStatus.first;

    statusSelectedStatus.value = '';
    streetController.text = '';
    cityController.text = '';
    zipCodeController.text = '';
    countryController.text = '';
    propertyTitleController.text = '';
    propertyFinalValController.text = '';
    propertyDocController.text = '';

    investPerMonthController.text = '';

    bundleController.text = '';

    uniteController.text = '';
    investPriceController.text = '';

    annualRentalController.text = '';
    devCapRateController.text = '';
    afterDevValueController.text = '';
    dispositionDate.value = Utils.timeStampToString(Timestamp.now());
    dispositionDateController.text = Utils.timeStampToString(Timestamp.now());

    perShareController.text = '';
    shareLeftController.text = '';
    averagePurchaseController.text = '';

    propertyVideoList.value = [];

    cashFinancingUrlController.text = '';
    cashFinancingNameController.text = '';

    propertyDetailsUrlController.text = '';
    propertyDetailsNameController.text = '';

    documentsUrlController.text = '';
    documentsNameController.text = '';

    afterARCController.text = '';
    afterDevCapController.text = '';
    projectMetricsDevValController.text = '';
    estimateDispositionDate.value = Utils.timeStampToString(Timestamp.now());
    estimateDispositionDateController.text =
        Utils.timeStampToString(Timestamp.now());

    // :::::::::: END ::::::::::::::::::::::::::::::::
  }

  void onPropertyDetails() {
    getPropertiesDetails();
    currentSelectedScreen.value = 1;
  }

  void onPropertyAdd() {
    selectedPropertyId.value = '';
    currentSelectedScreen.value = 1;
  }
}
