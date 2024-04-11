import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_button.dart';
import 'text_widget.dart';

void DeleteConfirmBox(BuildContext context, Function onYes) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
            height: 200,
            width: 400,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xA2573EF),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 2),
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  'Delete Confirm',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  'Are you sure you want to delete ?',
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      buttonText: 'Cancel',
                      onBtnPress: () {
                        Get.back();
                      },
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                    CustomButton(
                      buttonText: 'Delete',
                      onBtnPress: () {
                        Get.back();
                        onYes();
                      },
                      backgroundColor: Colors.red,
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      );
    },
  );
}
