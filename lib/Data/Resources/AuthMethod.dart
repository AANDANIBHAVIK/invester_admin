import 'package:admin/Data/Models/category_model.dart';
import 'package:admin/Data/Models/companies_model.dart';
import 'package:admin/Data/Models/property_model.dart';
import 'package:admin/Data/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String receivedID = '';

//get snapshot of current user data
  Future<UserModel> getUserDetails(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('Users').doc(uid).get();
    Map<String, dynamic> dataMap = snap.data() as Map<String, dynamic>;
    print(snap.data());
    return UserModel.fromJson(dataMap);
  }

  //get snapshot of Selected Property data
  Future<PropertyModel> getPropertyDetails(String pid) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('Properties').doc(pid).get();
    Map<String, dynamic> dataMap = snap.data() as Map<String, dynamic>;
    return PropertyModel.fromJson(dataMap);
  }

  //get Categories data
  Future<List<String>> getCategoryData() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection('Categories').doc('categoryID').get();

    List<String> _temp =
        await CategoryModel.fromJson(doc.data() ?? {}).categories ?? [];

    return _temp;
  }

  //get Companies data
  Future<List<CompaniesModel>> getCompaniesData() async {
    QuerySnapshot<Map<String, dynamic>> docs =
        await _firestore.collection('Companies').get();
    List<CompaniesModel> _temp = [];

    for (var i in docs.docs) {
      _temp.add(CompaniesModel.fromJson(i.data()));
    }

    return _temp;
  }

  String getUserId() {
    User currentUser = _auth.currentUser!;
    return currentUser.uid;
  }

  Future<String?> signUpEmailUser({
    required String email,
    required String password,
  }) async {
    String? res;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        res = credential.user?.uid;
      }
    } on FirebaseAuthException catch (e) {
      res = e.message.toString();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //
  // Future<String> verifyPhoneUser({
  //   required String receivedid,
  //   required String otp,
  // }) async {
  //   String res = 'some error occurred';
  //   try {
  //     if (otp.isNotEmpty) {
  //       // print('reciveIDotp ${receivedid}');
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: receivedid,
  //         smsCode: otp,
  //       );
  //       await _auth.signInWithCredential(credential).then((value) {
  //         res = 'success';
  //       });
  //     }
  //   } catch (err) {
  //     res = err.toString().split(']')[1];
  //     print(err);
  //   }
  //   return res;
  // }
  //
  // //login user
  //
  Future<String> signInUser(
      {required String email, required String password}) async {
    String res = "some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the field";
      }
    } catch (err) {
      res = err.toString().split(']')[1];
    }

    return res;
  }
}
