import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadDocumentToStorage(
      String childName, Uint8List file) async {
    String id = const Uuid().v1();
    Reference ref = _storage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future deleteDocumentToStorage(String imageUrl) async {
    try {
      var photoRef = _storage.refFromURL(imageUrl);
      await photoRef.delete();
      print('msg delete');
    } catch (e) {
      // print('msg delete ${e}');
    }
  }

  Future<String> uploadProfileToStorage(
      String childName, Uint8List file) async {
    String id = const Uuid().v1();
    Reference ref = _storage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> testStorage(String childName, PlatformFile file) async {
    String id = const Uuid().v1();
    Reference ref = _storage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putFile(file as File);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
