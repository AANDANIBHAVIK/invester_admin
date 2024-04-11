import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Utils/Widgets/custom_snackbar.dart';
import 'api_exception.dart';
import 'error_model.dart';

const String jsonContentType = 'application/json';

///
/// This class contain the Comman methods of API
///
class ApiManager {
  ///
  /// Replace base url with this
  ///
  static const String baseUrl =
      "https://us-central1-investtor--ms.cloudfunctions.net/app/";

  ///
  /// This method is used for call API for the `POST` method, need to pass API Url endpoint
  ///
  Future<dynamic> get(String url,
      {bool isLoaderShow = true, bool isErrorSnackShow = true}) async {
    Get.printInfo(info: 'Api Post, url $url');
    try {
      if (isLoaderShow) {
        EasyLoading.show();
      }

      ///
      /// Declare the header for the request, if user not loged in then pass emplty array as header
      /// or else pass the authentication token stored on login time
      ///
      Map<String, String> header = {'Content-Type': 'application/json'};

      Get.printInfo(info: 'header- ${header.toString()}');
      Get.printInfo(info: 'URL- ${baseUrl + url}');

      ///
      /// Make the post method api call with header and given parameter
      ///
      final request = http.MultipartRequest("GET", Uri.parse(baseUrl + url));
      request.headers.addAll(header);
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 15));
      print(response.headers);

      ///
      /// Handle response and errors
      ///
      var map = _returnResponse(response,
          isShow: isErrorSnackShow, isLoaderShow: isLoaderShow);

      ///
      /// Return the map response here and handle it in you model class accordigly
      ///
      return map;
    } on SocketException {
      Get.printInfo(info: 'No net');
      SnackBars.errorSnackBar(content: 'No Internet');
      throw FetchDataException('No Internet connection');
    } finally {
      if (isLoaderShow) {
        EasyLoading.dismiss();
      }
    }
  }

  ///
  /// This method is used for call API for the `POST` method, need to pass API Url endpoint
  ///
  Future<dynamic> post(String url, Map<String, dynamic> parameters,
      {String objcontentType = jsonContentType,
      bool isLoaderShow = true,
      bool isErrorSnackShow = true,
      http.MultipartFile? file}) async {
    Get.printInfo(info: 'Api Post, url $url');
    try {
      if (isLoaderShow) {
        EasyLoading.show();
      }

      ///
      /// Declare the header for the request, if user not loged in then pass emplty array as header
      /// or else pass the authentication token stored on login time
      ///
      Map<String, String> header = {'Content-Type': 'application/json'};

      Get.printInfo(info: 'header- ${header.toString()}');
      Get.printInfo(info: 'URL- ${baseUrl + url}');
      Get.printInfo(info: 'BODY PARAMS- $parameters');

      ///
      /// Make the post method api call with header and given parameter
      ///
      final request = http.Request("POST", Uri.parse(baseUrl + url));
      request.body = json.encode(parameters);
      // request.fields.addAll(parameters);
      // if (file != null) {
      //   request.files.add(file);
      // }

      request.headers.addAll(header);
      http.StreamedResponse response = await request.send();

      ///
      /// Handle response and errors
      ///
      var map = _returnResponse(response,
          isShow: isErrorSnackShow, isLoaderShow: isLoaderShow);

      ///
      /// Return the map response here and handle it in you model class accordigly
      ///
      return map;
    } on SocketException {
      Get.printInfo(info: 'No net');
      SnackBars.errorSnackBar(content: 'No Internet');
      throw FetchDataException('No Internet connection');
    } finally {
      if (isLoaderShow) {
        EasyLoading.dismiss();
      }
    }
  }

  ///
  /// This method is used for call API for the `POST` method, need to pass API Url endpoint
  ///
  Future<dynamic> delete(String url,
      {bool isLoaderShow = true, bool isErrorSnackShow = true}) async {
    Get.printInfo(info: 'Api Post, url $url');
    try {
      if (isLoaderShow) {
        EasyLoading.show();
      }

      ///
      /// Declare the header for the request, if user not loged in then pass emplty array as header
      /// or else pass the authentication token stored on login time
      ///
      Map<String, String> header = {'Content-Type': 'application/json'};

      Get.printInfo(info: 'header- ${header.toString()}');
      Get.printInfo(info: 'URL- ${url}');

      ///
      /// Make the post method api call with header and given parameter
      ///
      final request = http.Request("DELETE", Uri.parse(url));
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 15));
      print(response.headers);

      ///
      /// Handle response and errors
      ///
      var map = _returnResponse(response,
          isShow: isErrorSnackShow, isLoaderShow: isLoaderShow);

      ///
      /// Return the map response here and handle it in you model class accordigly
      ///
      return map;
    } on SocketException {
      Get.printInfo(info: 'No net');
      SnackBars.errorSnackBar(content: 'No Internet');
      throw FetchDataException('No Internet connection');
    } finally {
      if (isLoaderShow) {
        EasyLoading.dismiss();
      }
    }
  }

  dynamic _returnResponse(http.StreamedResponse response,
      {bool isShow = true, bool isLoaderShow = true}) async {
    if (isLoaderShow) {
      EasyLoading.dismiss();
    }
    var responseString = await response.stream.bytesToString();
    if (kDebugMode) {
      print(response.statusCode);
      print(responseString);
    }
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(responseString);
        // if (responseJson['code'] == 0) {
        //   if (isShow) {
        //     SnackBars.errorSnackBar(content: responseJson['msg']);
        //   }
        //   throw BadRequestException(responseJson['msg']);
        // }
        return responseJson;
      case 201:
        var responseJson = json.decode(responseString);
        // if (responseJson['code'] == 0) {
        //   if (isShow) {
        //     SnackBars.errorSnackBar(content: responseJson['msg']);
        //   }
        //   throw BadRequestException(responseJson['msg']);
        // }
        return responseJson;
      case 400:
        if (isShow) {
          SnackBars.errorSnackBar(
              content: ErrorModel.fromJson(json.decode(responseString))
                  .errorMessage!);
        }
        throw BadRequestException(
            ErrorModel.fromJson(json.decode(responseString)).errorMessage!);
      case 401:
        if (isShow) {
          SnackBars.errorSnackBar(
              content: ErrorModel.fromJson(json.decode(responseString))
                  .errorMessage!);
        }
        throw BadRequestException(
            ErrorModel.fromJson(json.decode(responseString)).errorMessage!);
      case 403:
        if (isShow) {
          SnackBars.errorSnackBar(
              content: ErrorModel.fromJson(json.decode(responseString))
                  .errorMessage!);
        }
        throw UnauthorisedException(
            ErrorModel.fromJson(json.decode(responseString)).errorMessage!);

      case 404:
        if (isShow) {
          SnackBars.errorSnackBar(
              content: ErrorModel.fromJson(json.decode(responseString))
                  .errorMessage!);
        }
        throw UnauthorisedException(
            ErrorModel.fromJson(json.decode(responseString)).errorMessage!);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
