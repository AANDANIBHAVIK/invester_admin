import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/screens/FaQ/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void addFaqBox(
  BuildContext context,
  FaqController controller, {
  String? question,
  String? answer,
  String? selectedID,
}) {
  controller.faqQuestionController.text = question ?? '';
  controller.faqAnswerController.text = answer ?? '';
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
                  selectedID == null ? 'Add FAQ' : 'Edit FAQ',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomFormTextField(
                  label: 'Question',
                  controller: controller.faqQuestionController,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  label: 'Answer',
                  controller: controller.faqAnswerController,
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
                        controller.addFaqData(selectedQA: selectedID);
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
