import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBars {
  ///
  /// Error SnackBar
  ///
  static errorSnackBar(
      {required String content, Color textColor = Colors.white}) {
    return Get.rawSnackbar(
        message: content,
        backgroundColor: Colors.red.withOpacity(0.8),
        duration: Duration(milliseconds: 1500),
        margin: const EdgeInsets.all(15),
        borderRadius: 10);
  }

  ///
  /// Success SnackBar
  ///
  static successSnackBar(
      {required String content, Color textColor = Colors.white}) {
    return Get.rawSnackbar(
        message: content,
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.green.withOpacity(0.8),
        margin: const EdgeInsets.all(15),
        borderRadius: 10);
  }
}
