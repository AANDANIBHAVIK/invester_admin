import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/FaQ/components/faq_table.dart';
import 'package:admin/screens/FaQ/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'components/dialogBox.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen();

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  FaqController faqController = Get.put(FaqController());

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    // final scaleFactor = MediaQuery.of(context).textScaleFactor;
    // // Calculate the desired font size based on the screen width and height
    // final fontSize = width *
    //     0.05 *
    //     scaleFactor; // Adjust the multiplication factor as needed
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Obx(
        () => Column(
          children: [
            Header(
              title: 'FAQs',
            ),
            Container(
              height: 800,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xA2573EF),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 2),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: faqController.isLoading.value
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              "FAQs",
                              fontSize: 25,
                            ),
                            Spacer(),
                            CustomButton(
                              buttonText: '+ Add',
                              onBtnPress: () async {
                                addFaqBox(Get.context!, faqController);
                              },
                              width: 10,
                              height: 4,
                              fontSize: 15,
                              borderRadius: 5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        FaqTable(),
                        Spacer(),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (faqController.faqCurrentPage.value > 0)
                                      faqController.faqCurrentPage.value--;
                                  },
                                  child: SvgPicture.asset(
                                      Assets.svgsPreviousIcon)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: textFieldBgColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextWidget(
                                    (faqController.faqCurrentPage.value + 1)
                                        .toString()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget('of'),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: textFieldBgColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextWidget(
                                    (faqController.faqDataList.length / 10)
                                        .ceil()
                                        .toString()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if ((faqController.faqCurrentPage.value +
                                            1) <
                                        (faqController.faqDataList.length /
                                                faqController
                                                    .faqRowsPerPage.value)
                                            .ceil())
                                      faqController.faqCurrentPage.value++;
                                  },
                                  child: SvgPicture.asset(Assets.svgsNextIcon)),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
