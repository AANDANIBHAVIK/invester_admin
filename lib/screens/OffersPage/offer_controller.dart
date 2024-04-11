// import 'package:admin/Data/Models/offers_model.dart';
// import 'package:admin/Data/Resources/AuthMethod.dart';
// import 'package:admin/Utils/Widgets/custom_snackbar.dart';
// import 'package:admin/Utils/utils.dart';
// import 'package:admin/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
//
// class OfferController extends GetxController {
//   // USERS DATA TABLE LIST
//
//   RxInt offerCurrentPage = 0.obs;
//   RxInt offerRowsPerPage = 10.obs;
//   List<DataRow> offerDataRowList = [];
//   RxList<OffersModel> offerDataList = <OffersModel>[].obs;
//   RxInt offerCurrentSortColumn = 0.obs;
//   RxBool offerIsAscending = true.obs;
//
//   RxString selectedOfferId = ''.obs;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final AuthMethod authMethod = AuthMethod();
//
//   List offerScreenList = [offerListScreen(), OfferDetailsScreen()];
//   RxInt currentSelectedScreen = 0.obs;
//
//   RxBool isLoading = false.obs;
//
//   // :::::::::::::::: COMPANY DETAILS VARIABLES ::::::::::::
//
//   TextEditingController returnTargetController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController subtitleController = TextEditingController();
//   RxString offerSelectedStatus = ''.obs;
//   List<String> offerStatus = [
//     '',
//     currentOffer,
//     futureOffer,
//   ];
//   RxList<String> tagsList = <String>[].obs;
//
//   // :::::::::::::::::::::: END ::::::::::::::::::::::::::::
//
//   @override
//   void onInit() {
//     getOfferDetails();
//     super.onInit();
//   }
//
//   getOfferDetails() async {
//     // Stream<QuerySnapshot<Map<String, dynamic>>> snap =
//
//     await _firestore.collection('Offers').snapshots().listen((event) {
//       offerDataList.clear();
//       for (var i in event.docs) {
//         offerDataList.add(OffersModel.fromJson(i.data()));
//       }
//     });
//   }
//
//   getSelectedOfferDetails(String cid) async {
//     DocumentSnapshot<Map<String, dynamic>> snap =
//         await _firestore.collection('Offers').doc(cid).get();
//     Map<String, dynamic> dataMap = snap.data() as Map<String, dynamic>;
//     return OffersModel.fromJson(dataMap);
//   }
//
//   void getSelectedOfferData() async {
//     isLoading.value = LoadingUtils(true);
//     try {
//       OffersModel offerData =
//           await getSelectedOfferDetails(selectedOfferId.value);
//
//       nameController.text = offerData.name ?? '';
//       ownerController.text = offerData.owner ?? '';
//       typeController.text = offerData.type ?? '';
//       foundedYearController.text = offerData.foundedYear ?? '';
//
//       sizeOfferController.text = offerData.sizeOfOffer ?? '';
//
//       locationController.text = offerData.location ?? '';
//
//       websiteController.text = offerData.website ?? '';
//       numOfEmpController.text = offerData.numOfEmp ?? '';
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       SnackBars.errorSnackBar(content: e.message.toString());
//       throw e;
//     } catch (e) {
//       SnackBars.errorSnackBar(content: e.toString());
//     }
//     isLoading.value = LoadingUtils(false);
//   }
//
//   Future setSelectedOfferData() async {
//     isLoading.value = LoadingUtils(true);
//     if (checkValid()) {
//       String id = '';
//       if (selectedOfferId.value == '') {
//         id = const Uuid().v1();
//       } else {
//         id = selectedOfferId.value;
//       }
//       try {
//         OffersModel offerData = OffersModel(
//           oid: id,
//         );
//         await _firestore.collection('Offers').doc(id).set(
//               offerData.toJson(),
//               SetOptions(merge: true),
//             );
//         onBack();
//         SnackBars.successSnackBar(content: 'Offer Setup Successfully.');
//       } on FirebaseAuthException catch (e) {
//         isLoading.value = LoadingUtils(false);
//         print(e);
//         SnackBars.errorSnackBar(content: e.message.toString());
//         throw e;
//       } catch (e) {
//         SnackBars.errorSnackBar(content: e.toString());
//       } finally {
//         isLoading.value = LoadingUtils(false);
//       }
//     } else {}
//     isLoading.value = LoadingUtils(false);
//   }
//
//   Future deleteOffer(
//     String pid,
//   ) async {
//     try {
//       await _firestore.collection('Offers').doc(pid).delete();
//
//       SnackBars.successSnackBar(content: 'Offer Delete Successfully.');
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       SnackBars.errorSnackBar(content: e.message.toString());
//       throw e;
//     } catch (e) {
//       SnackBars.errorSnackBar(content: e.toString());
//     }
//   }
//
//   bool checkValid() {
//     if (nameController.text.isEmpty ||
//         ownerController.text.isEmpty ||
//         typeController.text.isEmpty ||
//         foundedYearController.text.isEmpty ||
//         sizeOfferController.text.isEmpty ||
//         locationController.text.isEmpty ||
//         websiteController.text.isEmpty ||
//         numOfEmpController.text.isEmpty) {
//       SnackBars.errorSnackBar(content: 'Please Fill all Values');
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   void onBack() async {
//     currentSelectedScreen.value = 0;
//
//     //  ::::::::::::::::::: Clear all Data ::::::::::::::::::::::::::::::::::
//
//     nameController.text = '';
//     typeController.text = '';
//     ownerController.text = '';
//     foundedYearController.text = '';
//
//     locationController.text = '';
//
//     websiteController.text = '';
//
//     sizeOfferController.text = '';
//     numOfEmpController.text = '';
//
//     // :::::::::: END ::::::::::::::::::::::::::::::::
//   }
//
//   void onOfferDetails() {
//     getOfferDetails();
//     currentSelectedScreen.value = 1;
//   }
//
//   void onOfferAdd() {
//     selectedOfferId.value = '';
//     currentSelectedScreen.value = 1;
//   }
// }
