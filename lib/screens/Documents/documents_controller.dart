import 'dart:io';
import 'dart:typed_data';

import 'package:admin/Data/Models/document_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Data/Resources/storage_method.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DocumentsController extends GetxController {
  RxInt documentCurrentPage = 0.obs;
  RxInt documentRowsPerPage = 10.obs;
  List<DataRow> documentDataRowList = [];
  RxList<DocumentsModel> documentDataList = <DocumentsModel>[].obs;
  RxInt documentCurrentSortColumn = 0.obs;
  RxBool documentIsAscending = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  TextEditingController documentNameController = TextEditingController();
  TextEditingController documentUrlController = TextEditingController();
  Rx<Uint8List> documentsFile = Uint8List(0).obs;

  RxBool isLoading = false.obs;

  @override
  onInit() {
    getDocumentData();
    super.onInit();
  }

  getDocumentData() async {
    isLoading.value = LoadingUtils(true);
    await _firestore.collection('Documents').snapshots().listen((event) {
      documentDataList.clear();
      for (var i in event.docs) {
        documentDataList.add(DocumentsModel.fromJson(i.data()));
      }
    });
    isLoading.value = LoadingUtils(false);
  }

  addDocumentData({String? selectedDocument}) async {
    isLoading.value = LoadingUtils(true);
    try {
      await uploadDocumentFirebase();
      String id = '';
      if (selectedDocument == null) {
        id = const Uuid().v1();
      } else {
        id = selectedDocument;
      }

      print(id);
      DocumentsModel documentData = DocumentsModel(
          documents: Documents(
              fileName: documentNameController.text,
              fileUrl: documentUrlController.text),
          did: id);
      await _firestore.collection('Documents').doc(id).set(
            documentData.toJson(),
          );
      SnackBars.successSnackBar(content: 'Document Added Successfully.');
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

  deleteDocumentData(String? did, String fileUrl) async {
    // isLoading.value = LoadingUtils(true);
    try {
      await _firestore.collection('Documents').doc(did).delete();
      await StorageMethod().deleteDocumentToStorage(fileUrl);
      SnackBars.successSnackBar(content: 'Document Deleted Successfully.');
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

  Future getDocumentsStorage() async {
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
        Uint8List? documentFile = element.bytes;
        if (documentFile == null && element.path != null) {
          documentFile = await convertXFileToUint8List(File(element.path!));
        }
        if (documentFile != null) {
          EasyLoading.show();
          documentsFile.value = documentFile;
          documentNameController.text = element.name;
          EasyLoading.dismiss();
        }
      });
    }
    ;
  }

  Future uploadDocumentFirebase() async {
    if (documentsFile.value.isNotEmpty) {
      if (documentUrlController.text.isNotEmpty) {
        print('object');
        await StorageMethod()
            .deleteDocumentToStorage(documentUrlController.text);
      }
      documentUrlController.text = await StorageMethod()
          .uploadDocumentToStorage('documentsFile', documentsFile.value);
    }
  }
}
