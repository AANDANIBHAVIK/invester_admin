import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'components/dialogBox.dart';
import 'components/documents_table.dart';
import 'documents_controller.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen();

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  DocumentsController documentsController = Get.put(DocumentsController());

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
              title: 'Documents',
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
              child: documentsController.isLoading.value
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              "Documents",
                              fontSize: 25,
                            ),
                            Spacer(),
                            CustomButton(
                              buttonText: '+ Add',
                              onBtnPress: () async {
                                addDocumentBox(
                                    Get.context!, documentsController);
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
                        DocumentTable(),
                        Spacer(),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (documentsController
                                            .documentCurrentPage.value >
                                        0)
                                      documentsController
                                          .documentCurrentPage.value--;
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
                                child: TextWidget((documentsController
                                            .documentCurrentPage.value +
                                        1)
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
                                child: TextWidget((documentsController
                                            .documentDataList.length /
                                        10)
                                    .ceil()
                                    .toString()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if ((documentsController
                                                .documentCurrentPage.value +
                                            1) <
                                        (documentsController
                                                    .documentDataList.length /
                                                documentsController
                                                    .documentRowsPerPage.value)
                                            .ceil())
                                      documentsController
                                          .documentCurrentPage.value++;
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
