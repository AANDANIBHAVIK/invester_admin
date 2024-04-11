import 'dart:io';

import 'package:admin/Data/Models/setting_model.dart';
import 'package:admin/Data/Resources/storage_method.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController operatingAgreementController = TextEditingController();
  // RxString userEmail = ''.obs;
  TextEditingController secondaryListingAgreementController =
      TextEditingController();
  TextEditingController securitiesTransferAgreementController =
      TextEditingController();

  TextEditingController documentNameController = TextEditingController();
  TextEditingController documentUrlController = TextEditingController();
  Rx<Uint8List> documentImgFile = Uint8List(0).obs;

  TextEditingController placeholderNameController = TextEditingController();
  TextEditingController placeholderUrlController = TextEditingController();
  Rx<Uint8List> placeholderImgFile = Uint8List(0).obs;

  TextEditingController clientIdController = TextEditingController();
  TextEditingController secretsKeyController = TextEditingController();

  TextEditingController privacyPolicyController = TextEditingController();
  TextEditingController customerSupportController = TextEditingController();

  RxList<String> howToWorkVideoList = <String>[].obs;
  TextEditingController contentController = TextEditingController();

  RxBool isVideoEdited = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<SettingsModel> settingInfo = SettingsModel().obs;

  void onInit() {
    getDataFirebase();
    super.onInit();
  }

  getDataFirebase() async {
    settingInfo.value = SettingsModel();
    await _firestore
        .collection('Settings')
        .doc('SettingsInfo')
        .snapshots()
        .listen((event) {
      print(event);
      print("+++++++++++++");
      settingInfo.value = SettingsModel.fromJson(event.data()!);

      howToWorkVideoList.clear();
      addVideos(settingInfo.value.howItWork?.videos ?? []);
      placeholderImgFile.value = Uint8List(0);
      documentImgFile.value = Uint8List(0);

      print(settingInfo.value.howItWork?.content);

      operatingAgreementController.text =
          settingInfo.value.agreements?.operatingAgreement ?? '';
      secondaryListingAgreementController.text =
          settingInfo.value.agreements?.secondaryListingAgreement ?? '';
      securitiesTransferAgreementController.text =
          settingInfo.value.agreements?.securitiesTransferAgreement ?? '';

      clientIdController.text = settingInfo.value.plaidKey?.clientId ?? '';
      secretsKeyController.text = settingInfo.value.plaidKey?.secretkey ?? '';
      privacyPolicyController.text =
          settingInfo.value.documentUrl?.privacyPolicy ?? '';
      customerSupportController.text =
          settingInfo.value.documentUrl?.customerSupport ?? '';

      documentUrlController.text =
          settingInfo.value.accreditedInvestorInfo?.fileUrl ?? '';
      documentNameController.text =
          settingInfo.value.accreditedInvestorInfo?.fileName ?? '';

      placeholderUrlController.text =
          settingInfo.value.placeHolderImg?.fileUrl ?? '';
      placeholderNameController.text =
          settingInfo.value.placeHolderImg?.fileName ?? '';

      // howToWorkVideoList.addAll(settingInfo.value.howItWork?.videos ?? []);
      contentController.text = settingInfo.value.howItWork?.content ?? '';
    });
  }

  addVideos(List<String> list) async {
    // print("${list}::::::::-===-=-=-");
    for (var i = 0; i < list.length; i++) {
      await Future.delayed(const Duration(milliseconds: 0), () {
        // print("${list[i]}    ::::::::-===-=-=-");
        howToWorkVideoList.add(list[i]);
      });
    }
  }

  Future setDataToFirebase() async {
    try {
      await uploadDocumentFirebase();

      SettingsModel settingsModel = SettingsModel(
        agreements: Agreements(
            operatingAgreement: operatingAgreementController.text,
            secondaryListingAgreement: secondaryListingAgreementController.text,
            securitiesTransferAgreement:
                securitiesTransferAgreementController.text),
        accreditedInvestorInfo: PlaceHolderImg(
            fileUrl: documentUrlController.text,
            fileName: documentNameController.text),
        howItWork: HowItWork(
            content: contentController.text, videos: howToWorkVideoList.value),
        placeHolderImg: PlaceHolderImg(
            fileUrl: placeholderUrlController.text,
            fileName: placeholderNameController.text),
        plaidKey: PlaidKey(
            clientId: clientIdController.text,
            secretkey: secretsKeyController.text),
        documentUrl: DocumentUrl(
            privacyPolicy: privacyPolicyController.text,
            customerSupport: customerSupportController.text),
      );

      await _firestore.collection('Settings').doc('SettingsInfo').set(
            settingsModel.toJson(),
            SetOptions(merge: true),
          );

      SnackBars.successSnackBar(content: 'Setting Updated Successfully.');
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
  }

  Future uploadDocumentFirebase() async {
    if (documentImgFile.value.isNotEmpty) {
      if (documentUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(documentUrlController.text);
      }
      documentUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('settings', documentImgFile.value);
    }
    if (placeholderImgFile.value.isNotEmpty) {
      if (placeholderUrlController.text.isNotEmpty) {
        await StorageMethod()
            .deleteDocumentToStorage(placeholderUrlController.text);
      }
      placeholderUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('settings', placeholderImgFile.value);
    }
  }

  Future getDocumentsStorage() async {
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
          documentImgFile.value = documentFile;
          documentNameController.text = element.name;
          EasyLoading.dismiss();
        }
      });
    }
    ;
  }

  Future uploadVideoFirebase(String text) async {
    howToWorkVideoList.add(text);
    // var result = await FilePicker.platform.pickFiles(
    //   allowMultiple: true,
    //   type: FileType.video,
    // );
    // if (result == null) {
    //   print("No file selected");
    // } else {
    //   result.files.forEach((element) async {
    //     // var test = await StorageMethod().testStorage('test1', element);
    //     // print("++++++++++:::::::::++++++++++");
    //     // print(test);
    //     // print("++++++++++:::::::::++++++++++");
    //     Uint8List? videoFile = element.bytes;
    //     if (videoFile == null && element.path != null) {
    //       videoFile = await convertXFileToUint8List(File(element.path!));
    //     }
    //     if (videoFile != null) {
    //       EasyLoading.show();
    //       var _video = await StorageMethod()
    //           .uploadDocumentToStorage('settings/Videos', videoFile);
    //       isVideoEdited.value = true;
    //       howToWorkVideoList.add(_video);
    //       EasyLoading.dismiss();
    //     }
    //   });
    // }
    // ;
  }
}
