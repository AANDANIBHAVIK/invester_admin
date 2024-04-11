import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin_controller.dart';

void addAdminBox(
  BuildContext context,
  AdminController controller, {
  String? username,
  String? password,
  String? selectedID,
}) {
  controller.adminUsernameController.text = username ?? '';
  controller.adminPasswordController.text = password ?? '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
            height: 350,
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
                  height: 20,
                ),
                TextWidget(
                  selectedID == null ? 'Add Admin' : 'Edit Admin',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomFormTextField(
                  label: 'Email',
                  controller: controller.adminUsernameController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  label: 'Password',
                  controller: controller.adminPasswordController,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      buttonText: 'Back',
                      onBtnPress: () {
                        Get.back();
                      },
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                    CustomButton(
                      buttonText: 'Save',
                      onBtnPress: () {
                        controller.addAdminData(selectedQA: selectedID);
                        Get.back();
                      },
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
