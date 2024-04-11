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

import 'user_details_screen.dart';
import 'users_list_screen.dart';

class UsersController extends GetxController {
  // USERS DATA TABLE LIST

  RxInt currentPage = 0.obs;
  RxInt rowsPerPage = 10.obs;
  List<DataRow> dataRowList = [];
  RxList<UserModel> userDataList = <UserModel>[].obs;
  RxInt currentSortColumn = 0.obs;
  RxBool isAscending = true.obs;

  // USER TRANSACTION DATA TABLE LIST

  RxInt transactionCurrentPage = 0.obs;
  RxInt transactionRowsPerPage = 5.obs;
  List<DataRow> transactionDataRowList = [];
  RxList<Transactions> transactionDataList = <Transactions>[].obs;
  RxInt transactionCurrentSortColumn = 0.obs;
  RxBool transactionIsAscending = true.obs;

  RxString selectedUserId = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  List userScreenList = [UsersScreen(), UserDetailsScreen()];
  RxInt currentSelectedScreen = 0.obs;

  RxBool isLoading = false.obs;

  // :::::::::::::::: USER DETAILS VARIABLES ::::::::::::
  // RxString userName = ''.obs;
  // TextEditingController userNameController = TextEditingController();
  // RxString userEmail = ''.obs;
  TextEditingController userEmailController = TextEditingController();
  TextEditingController singInMethodController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  RxString userProfile = ''.obs;
  Rx<Uint8List> profileImgFile = Uint8List(0).obs;
  // RxString newUserProfile = ''.obs;
  ImagePicker imagePicker = ImagePicker();
  RxString userSelectedStatus = ''.obs;
  List<String> userStatus = [
    '',
    userNew,
    userPending,
    userApproved,
  ];

  RxString empSelectedStatus = ''.obs;
  List<String> empStatus = [
    '',
    selfEmployed,
    employed,
    unemployed,
    retired,
    student,
  ];
  RxBool isEmpInfoVisible = true.obs;
  // RxString employmentStatus = ''.obs;
  TextEditingController empNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController occIndustryController = TextEditingController();

  RxString dob = Utils.dateConvertor(DateTime.now()).obs;
  TextEditingController dobController = TextEditingController();

  TextEditingController socialNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  RxString relationSelectedStatus = ''.obs;
  List<String> relationStatus = [
    '',
    singleOrDating,
    married,
    domesticPartner,
    widowed,
    divorced
  ];

  RxString AMIASelectedStatus = ''.obs;
  List<String> AMIAStatus = [
    '',
    income,
    retirementSavings,
    gift,
    other,
  ];

  RxString accreditedSelectedStatus = noValue.obs;
  List<String> accreditedStatus = [
    yesValue,
    noValue,
  ];

  RxString riskSelectedStatus = ''.obs;
  List<String> riskStatus = [
    '',
    moderate,
    aggressive,
    conservative,
  ];

  RxString stockSelectedStatus = noValue.obs;
  List<String> stockStatus = [
    yesValue,
    noValue,
  ];

  RxString isPoliticalSelectedStatus = noValue.obs;
  List<String> politicalStatus = [
    yesValue,
    noValue,
  ];

  // RxString documentSelectedStatus = driverLicense.obs;
  // List<String> documentStatus = [
  //   driverLicense,
  //   socialSecurityCard,
  // ];

  // TextEditingController documentNameController = TextEditingController();
  // TextEditingController documentUrlController = TextEditingController();
  // Rx<Uint8List> documentImgFile = Uint8List(0).obs;
  //
  TextEditingController drivingLicenseNameController = TextEditingController();
  TextEditingController drivingLicenseUrlController = TextEditingController();
  Rx<Uint8List> drivingLicenseImgFile = Uint8List(0).obs;

  TextEditingController socialCardNameController = TextEditingController();
  TextEditingController socialCardUrlController = TextEditingController();
  Rx<Uint8List> socialCardImgFile = Uint8List(0).obs;

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
        .where(
          "accountInfo.typeName",
          isNotEqualTo: enterPrise,
        )
        .snapshots()
        .listen((event) {
      userDataList.clear();
      for (var i in event.docs) {
        userDataList.add(UserModel.fromJson(i.data()));
      }
    });
  }

  void getSelectedUserData() async {
    isLoading.value = LoadingUtils(true);
    transactionDataList.clear();
    propertyInfoCardView.clear();
    try {
      UserModel userData =
          await authMethod.getUserDetails(selectedUserId.value);
      // userNameController.text = userData.fName ?? '';
      userEmailController.text = userData.email ?? '';
      singInMethodController.text = userData.signInWith ?? '';
      userPhoneController.text = userData.phone ?? '';
      userProfile.value = userData.profileImg ?? '';
      userSelectedStatus.value = userData.status ?? '';

      empSelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.empStatus ?? '';

      if (empSelectedStatus.value == selfEmployed ||
          empSelectedStatus.value == employed) {
        isEmpInfoVisible.value = true;
      } else {
        isEmpInfoVisible.value = false;
      }

      empNameController.text = userData.accountInfo?.accountType?.individual
              ?.empInfoIndividual?.empName ??
          '';
      jobTitleController.text = userData.accountInfo?.accountType?.individual
              ?.empInfoIndividual?.jobTitle ??
          '';
      occIndustryController.text = userData.accountInfo?.accountType?.individual
              ?.empInfoIndividual?.occupationIndustry ??
          '';

      dob.value = Utils.timeStampToString(
          userData.accountInfo?.accountType?.individual?.personalInfo?.dob ??
              Timestamp.now());
      dobController.text = Utils.timeStampToString(
          userData.accountInfo?.accountType?.individual?.personalInfo?.dob ??
              Timestamp.now());
      socialNumberController.text = userData.accountInfo?.accountType
              ?.individual?.personalInfo?.socialNumber ??
          '';
      addressController.text = userData
              .accountInfo?.accountType?.individual?.personalInfo?.address ??
          '';
      cityController.text =
          userData.accountInfo?.accountType?.individual?.personalInfo?.city ??
              '';
      stateController.text =
          userData.accountInfo?.accountType?.individual?.personalInfo?.state ??
              '';
      zipController.text =
          userData.accountInfo?.accountType?.individual?.personalInfo?.zip ??
              '';
      relationSelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.relationStatus ?? '';
      AMIASelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.amiaAccount ?? '';
      accreditedSelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.isAccredited ?? false
              ? yesValue
              : noValue;
      riskSelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.riskLevel ?? '';
      stockSelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.isMemberStock ?? false
              ? yesValue
              : noValue;
      isPoliticalSelectedStatus.value =
          userData.accountInfo?.accountType?.individual?.isPolitical ?? false
              ? yesValue
              : noValue;

      // documentSelectedStatus.value = userData.accountInfo?.accountType
      //             ?.individual?.document?.isDrivingLicense ??
      //         true
      //     ? driverLicense
      //     : socialSecurityCard;

      drivingLicenseUrlController.text = userData.accountInfo?.accountType
              ?.individual?.document?.drivingLicenseUrl ??
          '';
      drivingLicenseNameController.text = userData.accountInfo?.accountType
              ?.individual?.document?.drivingLicenseName ??
          '';

      socialCardUrlController.text = userData.accountInfo?.accountType
              ?.individual?.document?.socialSecurityUrl ??
          '';
      socialCardNameController.text = userData.accountInfo?.accountType
              ?.individual?.document?.socialSecurityName ??
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
    // print(userProfile.value);
    // print(newUserProfile.value);
    // if (profileImgFile.value.isEmpty && userProfile.value.isEmpty) {
    //   SnackBars.errorSnackBar(content: 'Please Add Profile Image');
    //   return false;
    // } else
    if (
        // userNameController.text.isEmpty ||
        userEmailController.text.isEmpty ||
            // userPhoneController.text.isEmpty ||
            empSelectedStatus.value.isEmpty ||
            userSelectedStatus.value.isEmpty ||
            socialNumberController.text.isEmpty ||
            addressController.text.isEmpty ||
            cityController.text.isEmpty ||
            zipController.text.isEmpty ||
            stateController.text.isEmpty ||
            relationSelectedStatus.value.isEmpty ||
            AMIASelectedStatus.value.isEmpty ||
            accreditedSelectedStatus.value.isEmpty ||
            riskSelectedStatus.value.isEmpty ||
            stockSelectedStatus.value.isEmpty ||
            isPoliticalSelectedStatus.value.isEmpty ||
            (drivingLicenseImgFile.value.isEmpty &&
                drivingLicenseUrlController.text.isEmpty) ||
            (socialCardImgFile.value.isEmpty &&
                socialCardUrlController.text.isEmpty)) {
      SnackBars.errorSnackBar(content: 'Please Fill all Values');
      return false;
    } else if (isEmpInfoVisible.value) {
      if (empNameController.text.isEmpty ||
          jobTitleController.text.isEmpty ||
          occIndustryController.text.isEmpty) {
        SnackBars.errorSnackBar(content: 'Please Fill all Values');
        return false;
      }
      return true;
    } else {
      return true;
    }
  }

  Future setSelectedUserData() async {
    isLoading.value = LoadingUtils(true);
    if (checkValid()) {
      // String id = '';
      // if (selectedUserId.value == '') {
      //   id = const Uuid().v1();
      // } else {
      //   id = selectedUserId.value;
      // }
      // print(selectedUserId.value);
      // print(id);

      try {
        // if (newUserProfile.value.isNotEmpty && userProfile.value.isNotEmpty) {
        //   // print('User edit and add New image');
        //   await StorageMethod().deleteDocumentToStorage(userProfile.value);
        //   userProfile.value = '';
        // } else if (userProfile.value.isNotEmpty) {
        //   // print('User edit but not add new image');
        //   newUserProfile.value = userProfile.value;
        // } else if (newUserProfile.value.isEmpty) {
        //   // print('User don\'t add image');
        //   newUserProfile.value = placeHolderImg;
        // } else {
        //   // print('User Nothing');
        // }
        String id = selectedUserId.value;
        if (selectedUserId.value.isEmpty) {
          id = await signUpUser() ?? '';
          if (id.isEmpty) {
            SnackBars.errorSnackBar(content: 'Something went wrong!');
            return;
          }
        }
        await uploadDocumentFirebase();

        UserModel userData = UserModel(
            profileImg: userProfile.value,
            // fName: userNameController.text,
            email: userEmailController.text,
            signInWith: selectedUserId.value.isEmpty
                ? singInWithEmail
                : singInMethodController.text,
            phone: userPhoneController.text,
            status: userSelectedStatus.value,
            accountInfo: AccountInfo(
                accountType: AccountType(
                  individual: Individual(
                      empInfoIndividual: EmpInfoIndividual(
                          empName: empNameController.text,
                          jobTitle: jobTitleController.text,
                          occupationIndustry: occIndustryController.text),
                      amiaAccount: AMIASelectedStatus.value,
                      empStatus: empSelectedStatus.value,
                      isAccredited: accreditedSelectedStatus.value == yesValue
                          ? true
                          : false,
                      isMemberStock:
                          stockSelectedStatus.value == yesValue ? true : false,
                      isPolitical: isPoliticalSelectedStatus.value == yesValue
                          ? true
                          : false,
                      relationStatus: relationSelectedStatus.value,
                      riskLevel: riskSelectedStatus.value,
                      personalInfo: PersonalInfo(
                          dob: Utils.stringToTimeStamp(dob.value),
                          address: addressController.text,
                          city: cityController.text,
                          state: stateController.text,
                          zip: zipController.text,
                          socialNumber: socialNumberController.text),
                      document: Document(
                          drivingLicenseUrl: drivingLicenseUrlController.text,
                          drivingLicenseName: drivingLicenseNameController.text,
                          socialSecurityUrl: socialCardUrlController.text,
                          socialSecurityName: socialCardNameController.text)),
                ),
                type: individual),
            uid: id);

        // print(userData.toJson());
        await _firestore.collection('Users').doc(id).set(
              userData.toJson(),
              SetOptions(merge: true),
            );
        onBack();
        SnackBars.successSnackBar(content: 'Data Added Successfully.');
      } on FirebaseAuthException catch (e) {
        print(e);
        SnackBars.errorSnackBar(content: e.message.toString());
        isLoading.value = LoadingUtils(false);
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
      if (userProfile.value.isNotEmpty) {
        await StorageMethod().deleteDocumentToStorage(userProfile.value);
      }
      userProfile.value = await StorageMethod()
          .uploadDocumentToStorage('profileImg', profileImgFile.value);
    }

    if (drivingLicenseImgFile.value.isNotEmpty) {
      if (drivingLicenseUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(drivingLicenseUrlController.text);
      }
      drivingLicenseUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('documentImg/individual/drivingLicense',
              drivingLicenseImgFile.value);
    } else {
      print(
          ":::: Individual Driving Licesnse Documents are not uploaded to firebase something went wrong ::::");
    }
    if (socialCardImgFile.value.isNotEmpty) {
      if (socialCardUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(socialCardUrlController.text);
      }
      socialCardUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('documentImg/individual/socialSecurityCard',
              socialCardImgFile.value);
    } else {
      print(
          ":::: Individual Social Security Documents are not uploaded to firebase something went wrong ::::");
    }
  }

  uploadDocumentImage(int documentId) async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result == null) {
      print("No file selected");
    } else {
      result.files.forEach((element) async {
        EasyLoading.show();
        Uint8List? documentFile = element.bytes;
        if (documentFile == null && element.path != null) {
          documentFile = await convertXFileToUint8List(File(element.path!));
        }
        if (documentFile != null) {
          if (documentId == 0) {
            drivingLicenseImgFile.value = documentFile;
            drivingLicenseNameController.text = element.name;
          } else if (documentId == 1) {
            socialCardImgFile.value = documentFile;
            socialCardNameController.text = element.name;
          }
        }
        EasyLoading.dismiss();
      });
    }
  }

  Future deleteUsers(String uid, String profileImg, String drivingLicenseDoc,
      String socialSecurityDoc) async {
    try {
      await DeleteUserRepository().deleteUser(uid);
      await _firestore.collection('Users').doc(uid).delete();
      await StorageMethod().deleteDocumentToStorage(profileImg);
      await StorageMethod().deleteDocumentToStorage(drivingLicenseDoc);
      await StorageMethod().deleteDocumentToStorage(socialSecurityDoc);
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

    selectedUserId.value = '';

    userProfile.value = '';
    profileImgFile.value = Uint8List(0);

    // userNameController.text = '';
    userEmailController.text = '';
    userPasswordController.text = '';
    singInMethodController.text = '';
    userPhoneController.text = '';
    empSelectedStatus.value = '';
    userSelectedStatus.value = '';
    empNameController.text = '';

    jobTitleController.text = '';

    occIndustryController.text = '';

    dobController.text = Utils.timeStampToString(Timestamp.now());
    dob.value = Utils.timeStampToString(Timestamp.now());

    socialNumberController.text = '';

    addressController.text = '';
    cityController.text = '';
    stateController.text = '';
    zipController.text = '';
    relationSelectedStatus.value = '';
    AMIASelectedStatus.value = '';
    accreditedSelectedStatus.value = yesValue;

    riskSelectedStatus.value = '';
    stockSelectedStatus.value = yesValue;
    isPoliticalSelectedStatus.value = yesValue;

    drivingLicenseUrlController.text = '';
    drivingLicenseNameController.text = '';
    drivingLicenseImgFile.value = Uint8List(0);

    socialCardUrlController.text = '';
    socialCardNameController.text = '';
    socialCardImgFile.value = Uint8List(0);

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
    selectedUserId.value = '';
    currentSelectedScreen.value = 1;
  }

  Future<String?> signUpUser() async {
    isLoading.value = true;

    String? res = await AuthMethod().signUpEmailUser(
        email: userEmailController.text, password: userPasswordController.text);

    isLoading.value = false;

    if (res != null) {
      print("user created successfully");
    }
    return res;
  }
}
