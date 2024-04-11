import 'dart:io';

import 'package:admin/Data/Models/account_info_model.dart';
import 'package:admin/Data/Models/property_model.dart';
import 'package:admin/Data/Models/user_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Data/Resources/delete_auth_user.dart';
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
import 'package:image_picker/image_picker.dart';

import 'enterprise_details_screen.dart';
import 'enterprise_list_screen.dart';

class EnterpriseController extends GetxController {
  // USERS DATA TABLE LIST

  RxInt currentPage = 0.obs;
  RxInt rowsPerPage = 10.obs;
  List<DataRow> dataRowList = [];
  RxList<UserModel> enterpriseDataList = <UserModel>[].obs;
  RxInt currentSortColumn = 0.obs;
  RxBool isAscending = true.obs;

  // USER TRANSACTION DATA TABLE LIST

  RxInt transactionCurrentPage = 0.obs;
  RxInt transactionRowsPerPage = 5.obs;
  List<DataRow> transactionDataRowList = [];
  RxList<Transactions> transactionDataList = <Transactions>[].obs;
  RxInt transactionCurrentSortColumn = 0.obs;
  RxBool transactionIsAscending = true.obs;

  RxString selectedenterpriseId = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  List enterpriseScreenList = [CompaniesScreen(), enterpriseDetailsScreen()];
  RxInt currentSelectedScreen = 0.obs;

  RxBool isLoading = false.obs;

  // :::::::::::::::: enterprise DETAILS VARIABLES ::::::::::::
  // RxString userName = ''.obs;
  // TextEditingController enterpriseUserNameController = TextEditingController();
  // RxString userEmail = ''.obs;
  TextEditingController enterpriseEmailController = TextEditingController();
  TextEditingController singInMethodController = TextEditingController();
  TextEditingController enterprisePhoneController = TextEditingController();
  TextEditingController enterprisePasswordController = TextEditingController();
  RxString enterpriseProfile = ''.obs;
  // RxString newenterpriseProfile = ''.obs;
  Rx<Uint8List> profileImgFile = Uint8List(0).obs;

  ImagePicker imagePicker = ImagePicker();

  RxString userSelectedStatus = ''.obs;
  List<String> userStatus = [
    '',
    userNew,
    userPending,
    userApproved,
  ];

  TextEditingController enterpriseNameController = TextEditingController();
  RxString formationDate = Utils.dateConvertor(DateTime.now()).obs;
  TextEditingController formationDateController = TextEditingController();
  TextEditingController signatoryTitleController = TextEditingController();
  TextEditingController identificationNumberController =
      TextEditingController();

  TextEditingController EINVerificationUrlController = TextEditingController();
  TextEditingController EINVerificationNameController = TextEditingController();
  Rx<Uint8List> EINVerificationImgFile = Uint8List(0).obs;

  TextEditingController operatingAgreementUrlController =
      TextEditingController();
  TextEditingController operatingAgreementNameController =
      TextEditingController();
  Rx<Uint8List> operatingAgreementImgFile = Uint8List(0).obs;

  TextEditingController certificateOfFormationUrlController =
      TextEditingController();
  TextEditingController certificateOfFormationNameController =
      TextEditingController();
  Rx<Uint8List> certificateOfFormationImgFile = Uint8List(0).obs;

  RxList<String> statementList = <String>[].obs;

  // :::::::::::: BANK VARIABLES :::::::::::::

  RxList<Items> accountInfoCardView = <Items>[].obs;

  // :::::::::::: PROPERTY VARIABLES :::::::::::::

  RxList<PropertyCardInfoModel> propertyInfoCardView =
      <PropertyCardInfoModel>[].obs;

  @override
  void onInit() {
    getUsersDetails();
    super.onInit();
  }

  getUsersDetails() async {
    // Stream<QuerySnapshot<Map<String, dynamic>>> snap =

    await _firestore
        .collection('Users')
        .where("accountInfo.typeName", isEqualTo: enterPrise)
        .snapshots()
        .listen((event) {
      enterpriseDataList.clear();
      for (var i in event.docs) {
        enterpriseDataList.add(UserModel.fromJson(i.data()));
      }
    });
  }

  void getSelectedUserData() async {
    isLoading.value = LoadingUtils(true);
    transactionDataList.clear();
    propertyInfoCardView.clear();
    try {
      UserModel userData =
          await authMethod.getUserDetails(selectedenterpriseId.value);

      print(userData.toJson());

      // enterpriseUserNameController.text = userData.fName ?? '';
      enterpriseEmailController.text = userData.email ?? '';
      singInMethodController.text = userData.signInWith ?? '';
      enterprisePhoneController.text = userData.phone ?? '';
      enterpriseProfile.value = userData.profileImg ?? '';
      userSelectedStatus.value = userData.status ?? '';

      enterpriseNameController.text = userData.accountInfo?.accountType
              ?.enterprise?.empInfoEnterprise?.enterpriceName ??
          '';
      formationDate.value = Utils.timeStampToString(userData.accountInfo
              ?.accountType?.enterprise?.empInfoEnterprise?.formationDate ??
          Timestamp.now());
      formationDateController.text = Utils.timeStampToString(userData
              .accountInfo
              ?.accountType
              ?.enterprise
              ?.empInfoEnterprise
              ?.formationDate ??
          Timestamp.now());
      signatoryTitleController.text = userData.accountInfo?.accountType
              ?.enterprise?.empInfoEnterprise?.signatoryTitle ??
          '';
      identificationNumberController.text = userData.accountInfo?.accountType
              ?.enterprise?.empInfoEnterprise?.empIndentificationNum ??
          '';

      statementList.value =
          userData.accountInfo?.accountType?.enterprise?.statements ?? [];

      print(userData.accountInfo?.accountType?.enterprise?.statements);
      EINVerificationUrlController.text = userData.accountInfo?.accountType
              ?.enterprise?.documents?.eniVerification?.fileUrl ??
          '';
      EINVerificationNameController.text = userData.accountInfo?.accountType
              ?.enterprise?.documents?.eniVerification?.fileName ??
          '';

      certificateOfFormationUrlController.text = userData
              .accountInfo
              ?.accountType
              ?.enterprise
              ?.documents
              ?.formationCertificate
              ?.fileUrl ??
          '';
      certificateOfFormationNameController.text = userData
              .accountInfo
              ?.accountType
              ?.enterprise
              ?.documents
              ?.formationCertificate
              ?.fileName ??
          '';
      operatingAgreementUrlController.text = userData.accountInfo?.accountType
              ?.enterprise?.documents?.operatingAgreement?.fileUrl ??
          '';
      operatingAgreementNameController.text = userData.accountInfo?.accountType
              ?.enterprise?.documents?.operatingAgreement?.fileName ??
          '';

      // :::::::::::::::::: GET BANK INFO :::::::::::::::::::

      accountInfoCardView.value = userData.bankAccountInfo?.items ?? [];

      //::::::::::::::::::: GET TRANSACTION DATA :::::::::::::::::
      for (var i in userData.bankAccountInfo?.transactions ?? []) {
        transactionDataList.add(i);
      }

      //::::::::::::::::::: GET PROPERTY DATA :::::::::::::::::

      for (PropertyInfo i in userData.propertyInfo ?? []) {
        PropertyModel propertyData =
            await authMethod.getPropertyDetails(i.pid!);
        propertyInfoCardView.add(
          PropertyCardInfoModel(
            returnOnInvestment: i.returnOnInvestment,
            earns: i.earns,
            invested: i.invested,
            investedDate: i.investedDate,
            investmentValue: i.investmentValue,
            pid: i.pid,
            images: propertyData.image,
            sold: propertyData.sold,
            name: propertyData.address?.street,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      SnackBars.errorSnackBar(content: e.message.toString());
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    } finally {
      isLoading.value = LoadingUtils(false);
    }
  }

  bool checkValid() {
    print((EINVerificationImgFile.value.isEmpty &&
        EINVerificationUrlController.text.isEmpty));
    // print(enterpriseProfile.value);
    // print(newenterpriseProfile.value);
    if (profileImgFile.value.isEmpty && enterpriseProfile.value.isEmpty) {
      SnackBars.errorSnackBar(content: 'Please Add Profile Image');
      return false;
    } else if (
        // enterpriseUserNameController.text.isEmpty ||
        enterpriseEmailController.text.isEmpty ||
            enterprisePhoneController.text.isEmpty ||
            formationDateController.text.isEmpty ||
            userSelectedStatus.value.isEmpty ||
            signatoryTitleController.text.isEmpty ||
            enterpriseNameController.text.isEmpty ||
            (EINVerificationImgFile.value.isEmpty &&
                EINVerificationUrlController.text.isEmpty) ||
            (certificateOfFormationImgFile.value.isEmpty &&
                certificateOfFormationUrlController.text.isEmpty) ||
            (operatingAgreementImgFile.value.isEmpty &&
                operatingAgreementUrlController.text.isEmpty)) {
      SnackBars.errorSnackBar(content: 'Please Fill all Values');
      return false;
    } else {
      return true;
    }
  }

  Future setSelectedenterpriseData() async {
    isLoading.value = LoadingUtils(true);
    if (checkValid()) {
      try {
        // if (newenterpriseProfile.value.isNotEmpty &&
        //     enterpriseProfile.value.isNotEmpty) {
        //   // print('User edit and add New image');
        //   await StorageMethod().deleteDocumentToStorage(enterpriseProfile.value);
        //   enterpriseProfile.value = '';
        // } else if (enterpriseProfile.value.isNotEmpty) {
        //   // print('User edit but not add new image');
        //   newenterpriseProfile.value = enterpriseProfile.value;
        // } else if (newenterpriseProfile.value.isEmpty) {
        //   // print('User don\'t add image');
        //   newenterpriseProfile.value = placeHolderImg;
        // } else {
        //   // print('User Nothing');
        // }
        String id = selectedenterpriseId.value;
        if (selectedenterpriseId.value.isEmpty) {
          id = await signUpUser() ?? '';
          if (id.isEmpty) {
            SnackBars.errorSnackBar(content: 'Something went wrong!');
            return;
          }
        }
        await uploadDocumentFirebase();
        UserModel userData = UserModel(
            profileImg: enterpriseProfile.value,
            // fName: enterpriseUserNameController.text,
            email: enterpriseEmailController.text,
            signInWith: selectedenterpriseId.value.isEmpty
                ? singInWithEmail
                : singInMethodController.text,
            phone: enterprisePhoneController.text,
            status: userSelectedStatus.value,
            accountInfo: AccountInfo(
                accountType: AccountType(
                  enterprise: Enterprise(
                      statements: statementList.value,
                      empInfoEnterprise: EmpInfoEnterprise(
                          enterpriceName: enterpriseNameController.text,
                          empIndentificationNum:
                              identificationNumberController.text,
                          signatoryTitle: signatoryTitleController.text,
                          formationDate:
                              Utils.stringToTimeStamp(formationDate.value)),
                      documents: Documents(
                        eniVerification: DocumentUserFile(
                          fileName: EINVerificationNameController.text,
                          fileUrl: EINVerificationUrlController.text,
                        ),
                        formationCertificate: DocumentUserFile(
                          fileName: certificateOfFormationNameController.text,
                          fileUrl: certificateOfFormationUrlController.text,
                        ),
                        operatingAgreement: DocumentUserFile(
                          fileName: operatingAgreementNameController.text,
                          fileUrl: operatingAgreementUrlController.text,
                        ),
                      )),
                ),
                type: enterPrise),
            uid: id);

        print(userData.toJson());
        await _firestore.collection('Users').doc(id).set(
              userData.toJson(),
              SetOptions(merge: true),
            );
        onBack();
        SnackBars.successSnackBar(content: 'Data Added Successfully.');
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

  Future uploadDocumentFirebase() async {
    if (profileImgFile.value.isNotEmpty) {
      if (enterpriseProfile.value.isNotEmpty) {
        await StorageMethod().deleteDocumentToStorage(enterpriseProfile.value);
      }
      enterpriseProfile.value = await StorageMethod()
          .uploadDocumentToStorage('profileImg', profileImgFile.value);
    }
    if (EINVerificationImgFile.value.isNotEmpty) {
      if (EINVerificationUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(EINVerificationUrlController.text);
      }
      EINVerificationUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('documentImg/enterprise/einVerification',
              EINVerificationImgFile.value);
    }
    if (operatingAgreementImgFile.value.isNotEmpty) {
      if (operatingAgreementUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(operatingAgreementUrlController.text);
      }
      operatingAgreementUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('documentImg/enterprise/operatingAgreement',
              operatingAgreementImgFile.value);
    }
    if (certificateOfFormationImgFile.value.isNotEmpty) {
      if (certificateOfFormationUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(certificateOfFormationUrlController.text);
      }

      certificateOfFormationUrlController.text = await StorageMethod()
          .uploadDocumentToStorage(
              'documentImg/enterprise/formationCertificate',
              certificateOfFormationImgFile.value);
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
            EINVerificationImgFile.value = documentFile;
            EINVerificationNameController.text = element.name;
          } else if (fileType == 2) {
            operatingAgreementImgFile.value = documentFile;
            operatingAgreementNameController.text = element.name;
          } else if (fileType == 3) {
            certificateOfFormationImgFile.value = documentFile;
            certificateOfFormationNameController.text = element.name;
          }

          EasyLoading.dismiss();
        }
      });
    }
    ;
  }

  // uploadDocumentImage() async {
  //   var result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     type: FileType.image,
  //   );
  //
  //   if (result == null) {
  //     print("No file selected");
  //   } else {
  //     result.files.forEach((element) async {
  //       EasyLoading.show();
  //       Uint8List? documentImgFile = element.bytes;
  //       if (documentImgFile == null && element.path != null) {
  //         documentImgFile = await convertXFileToUint8List(File(element.path!));
  //       }
  //       if (documentImgFile != null) {
  //         if (documentUrlController.text.isNotEmpty) {
  //           await StorageMethod()
  //               .deleteDocumentToStorage(documentUrlController.text);
  //         }
  //         documentNameController.text = element.name;
  //         documentUrlController.text = await StorageMethod()
  //             .uploadProfileToStorage('profileImg', documentImgFile);
  //       }
  //       EasyLoading.dismiss();
  //     });
  //   }
  // }

  Future deleteUsers(String uid, String profileImg) async {
    try {
      await DeleteUserRepository().deleteUser(uid);
      await _firestore.collection('Users').doc(uid).delete();
      await await StorageMethod().deleteDocumentToStorage(profileImg);

      SnackBars.successSnackBar(content: 'User Deleted Successfully.');
    } on FirebaseAuthException catch (e) {
      print(e);
      SnackBars.errorSnackBar(content: e.message.toString());
      throw e;
    } catch (e) {
      SnackBars.errorSnackBar(content: e.toString());
    }
  }

  void onBack() async {
    currentSelectedScreen.value = 0;

    //  ::::::::::::::::::: Clear all Data ::::::::::::::::::::::::::::::::::

    selectedenterpriseId.value = '';
    userSelectedStatus.value = '';
    enterpriseProfile.value = '';
    profileImgFile.value = Uint8List(0);
    // newenterpriseProfile.value = '';

    // enterpriseUserNameController.text = '';
    enterpriseEmailController.text = '';
    singInMethodController.text = '';
    enterprisePhoneController.text = '';
    enterprisePasswordController.text = '';
    enterpriseNameController.text = '';
    signatoryTitleController.text = '';
    identificationNumberController.text = '';
    statementList.clear();

    EINVerificationUrlController.text = '';
    EINVerificationNameController.text = '';
    EINVerificationImgFile.value = Uint8List(0);
    certificateOfFormationUrlController.text = '';
    certificateOfFormationNameController.text = '';
    certificateOfFormationImgFile.value = Uint8List(0);
    operatingAgreementUrlController.text = '';
    operatingAgreementNameController.text = '';
    operatingAgreementImgFile.value = Uint8List(0);

    formationDateController.text = Utils.timeStampToString(Timestamp.now());
    formationDate.value = Utils.timeStampToString(Timestamp.now());

    accountInfoCardView.clear();
    transactionDataList.clear();
    propertyInfoCardView.clear();
    // :::::::::: END ::::::::::::::::::::::::::::::::
  }

  void onUserDetails() {
    getUsersDetails();
    currentSelectedScreen.value = 1;
  }

  void onUserAdd() {
    selectedenterpriseId.value = '';
    currentSelectedScreen.value = 1;
  }

  Future<String?> signUpUser() async {
    String? res;
    try {
      if (enterpriseEmailController.text.isNotEmpty ||
          enterprisePasswordController.text.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: enterpriseEmailController.text,
                password: enterprisePasswordController.text);

        res = credential.user?.uid;
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = LoadingUtils(true);
      res = e.message.toString();
      return '';
    } catch (err) {
      res = err.toString();
      return '';
    } finally {
      isLoading.value = LoadingUtils(true);
    }

    if (res != null) {
      print("user created successfully");
    }
    return res;
  }
}
