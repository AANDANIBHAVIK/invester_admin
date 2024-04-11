import 'package:admin/Data/Models/faq_model.dart';
import 'package:admin/Data/Resources/AuthMethod.dart';
import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:admin/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FaqController extends GetxController {
  RxInt faqCurrentPage = 0.obs;
  RxInt faqRowsPerPage = 10.obs;
  List<DataRow> faqDataRowList = [];
  RxList<FaqModel> faqDataList = <FaqModel>[].obs;
  RxInt faqCurrentSortColumn = 0.obs;
  RxBool faqIsAscending = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthMethod authMethod = AuthMethod();

  TextEditingController faqQuestionController = TextEditingController();
  TextEditingController faqAnswerController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  onInit() {
    getFaqData();
    super.onInit();
  }

  getFaqData() async {
    isLoading.value = LoadingUtils(true);
    await _firestore.collection('Faq').snapshots().listen((event) {
      faqDataList.clear();
      for (var i in event.docs) {
        faqDataList.add(FaqModel.fromJson(i.data()));
      }
    });
    isLoading.value = LoadingUtils(false);
  }

  addFaqData({String? selectedQA}) async {
    // isLoading.value = LoadingUtils(true);
    try {
      String id = '';
      if (selectedQA == null) {
        id = const Uuid().v1();
      } else {
        id = selectedQA;
      }

      print(id);

      FaqModel faqData = FaqModel(
          questions: Questions(
              question: faqQuestionController.text,
              answer: faqAnswerController.text),
          qid: id);
      await _firestore.collection('Faq').doc(id).set(
            faqData.toJson(),
          );
      SnackBars.successSnackBar(content: 'FAQ Added Successfully.');
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

  deleteFaqData(String? qid) async {
    // isLoading.value = LoadingUtils(true);
    try {
      await _firestore.collection('Faq').doc(qid).delete();
      SnackBars.successSnackBar(content: 'FAQ Deleted Successfully.');
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
