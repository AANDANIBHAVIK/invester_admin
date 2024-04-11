import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 1}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

bool LoadingUtils(bool value) {
  if (value) {
    EasyLoading.show();
    return true;
  } else {
    EasyLoading.dismiss();
    return false;
  }
}

Future<Uint8List> convertXFileToUint8List(File file) async {
  Uint8List bytes = await file.readAsBytes();
  return bytes;
}

class Utils {
  static String dateConvertor(DateTime dateTime) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  static DateTime stringToDateConvertor(String dateTime) {
    DateTime formattedDate = DateFormat('dd/MM/yyyy').parse(dateTime);
    return formattedDate;
  }

  static Timestamp stringToTimeStamp(String date) {
    // Convert the string to DateTime
    DateTime dateTime = stringToDateConvertor(date);

    // Convert the DateTime to Firebase Timestamp
    Timestamp timestamp = Timestamp.fromDate(dateTime);

    // print('Firebase Timestamp: $timestamp');
    return timestamp;
  }

  static String timeStampToString(Timestamp timestamp) {
    // Convert the Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime to String
    String formattedDateTime = dateConvertor(dateTime);
    return formattedDateTime;
  }

  static String stringTimeStampToStringDate(String time) {
    // Convert the Timestamp to DateTime
    // String timestampString = "2023-08-03T12:33:52.117397Z";
    DateTime timestamp = DateTime.parse(time);

    DateFormat format = DateFormat("dd/MM/yyyy HH:mm:ss");
    String formattedTimestamp = format.format(timestamp);

    // Format the DateTime to String
    return formattedTimestamp;
  }

  /// Open image gallery and pick an image
  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  /// Open image gallery and pick an image
  static Future<XFile?> pickImageFromCamera() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  // /// Pick Image From Gallery and return a File
  // static Future<CroppedFile?> cropSelectedImage(String filePath) async {
  //   return await ImageCropper().cropImage(
  //     sourcePath: filePath,
  //     // aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: AppColor.blackColor,
  //           toolbarWidgetColor: AppColor.blueColor,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Crop Image',
  //         aspectRatioLockEnabled: false,
  //         minimumAspectRatio: 1.0,
  //         aspectRatioPickerButtonHidden: false,
  //       ),
  //     ],
  //   );
  // }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url.isNotEmpty ?? false, 'Url cannot be empty');
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      RegExpMatch? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }
}
