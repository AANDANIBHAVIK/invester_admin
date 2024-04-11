import 'dart:io';

import 'package:admin/Utils/Widgets/common_flie_btns.dart';
import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/pdf_view_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/Utils/utils.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'Components/common_bank_detail.dart';
import 'Components/common_choose_button.dart';
import 'Components/common_property_detail.dart';
import 'Components/enterprise_transactions_table.dart';
import 'enterprise_controller.dart';

class enterpriseDetailsScreen extends StatefulWidget {
  @override
  State<enterpriseDetailsScreen> createState() =>
      _enterpriseDetailsScreenState();
}

class _enterpriseDetailsScreenState extends State<enterpriseDetailsScreen> {
  EnterpriseController enterpriseController = Get.find();

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // print("${width} + ${height}");
    print(enterpriseController.profileImgFile.value.isEmpty);
    return Obx(
      () => enterpriseController.isLoading.value
          ? Container()
          : Container(
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
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            "enterpriseDetails",
                            fontSize: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomButton(
                        buttonText: 'Save',
                        onBtnPress: () async {
                          await enterpriseController
                              .setSelectedenterpriseData();
                          // enterpriseController.onBack();
                          // enterpriseController.currentSelectedScreen.value = 0;
                        },
                        width: 10,
                        height: 4,
                        fontSize: 15,
                        borderRadius: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                        buttonText: 'Back',
                        onBtnPress: () {
                          enterpriseController.onBack();
                        },
                        width: 10,
                        height: 4,
                        fontSize: 15,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                  Divider(),
                  // TextWidget(
                  //   "Account Details *",
                  //   fontSize: 23,
                  //   color: Colors.black,
                  //   fontWeight: FontWeight.w500,
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            // margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                image:
                                    // image: NetworkImage(enterpriseController
                                    //         .newenterpriseProfile.isEmpty
                                    //     ? enterpriseController
                                    //             .enterpriseProfile.value.isEmpty
                                    //         ? placeHolderImg
                                    //         : enterpriseController
                                    //             .enterpriseProfile.value
                                    //     : enterpriseController
                                    //         .newenterpriseProfile.value),
                                    enterpriseController
                                            .profileImgFile.value.isNotEmpty
                                        ? DecorationImage(
                                            image: MemoryImage(
                                                enterpriseController
                                                    .profileImgFile.value),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: NetworkImage(
                                                enterpriseController
                                                        .enterpriseProfile
                                                        .value
                                                        .isEmpty
                                                    ? placeHolderImg
                                                    : enterpriseController
                                                        .enterpriseProfile
                                                        .value),
                                            fit: BoxFit.cover),
                                // image: enterpriseController.profileImgFile == null ?NetworkImage(enterpriseController.enterpriseProfile.value) : MemoryImage(enterpriseController.profileImgFile!.value),

                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(2, 2))
                                ]),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: InkWell(
                                onTap: () async {
                                  var result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.image,
                                  );

                                  if (result == null) {
                                    print("No file selected");
                                  } else {
                                    result.files.forEach((element) async {
                                      Uint8List? imageFile = element.bytes;
                                      if (imageFile == null &&
                                          element.path != null) {
                                        imageFile =
                                            await convertXFileToUint8List(
                                                File(element.path!));
                                      }
                                      if (imageFile != null) {
                                        enterpriseController.profileImgFile
                                            .value = await imageFile;
                                        // print("+++++++++++++++++++++STRAT");
                                        // print(enterpriseController
                                        //     .profileImgFile.value);
                                        // print("+++++++++++++++++++++END");
                                        // EasyLoading.show();
                                        // var _image = await StorageMethod()
                                        //     .uploadProfileToStorage(
                                        //         'profileImg', imageFile);
                                        // enterpriseController
                                        //     .newenterpriseProfile.value = _image;
                                        // EasyLoading.dismiss();
                                      }
                                    });
                                    print(enterpriseController
                                        .profileImgFile?.value);
                                  }
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.camera,
                                      color: Colors.blueAccent,
                                      size: 25,
                                    ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 0,
                    childAspectRatio: width /
                        (defaultHeight /
                            (!Responsive.isDesktop(context)
                                ? Responsive.isMobile(context)
                                    ? 9.5
                                    : 4.5
                                : 2.5)),
                    crossAxisCount: Responsive.isMobile(context)
                        ? 1
                        : Responsive.isTablet(context)
                            ? 2
                            : 3,
                    crossAxisSpacing: 20,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      // CustomFormTextField(
                      //   label: 'UserName *',
                      //   controller:
                      //       enterpriseController.enterpriseUserNameController,
                      // ),
                      CustomFormTextField(
                        label: 'Email *',
                        controller:
                            enterpriseController.enterpriseEmailController,
                      ),
                      if (enterpriseController
                          .selectedenterpriseId.value.isEmpty) ...[
                        CustomFormTextField(
                          label: 'Password *',
                          controller:
                              enterpriseController.enterprisePasswordController,
                        ),
                      ],
                      CustomFormTextField(
                        label: 'Phone *',
                        controller:
                            enterpriseController.enterprisePhoneController,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextWidget(
                    "Account Details *",
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 0,
                    childAspectRatio: width /
                        (defaultHeight /
                            (!Responsive.isDesktop(context)
                                ? Responsive.isMobile(context)
                                    ? 9.5
                                    : 4.5
                                : 2.5)),
                    crossAxisCount: Responsive.isMobile(context)
                        ? 1
                        : Responsive.isTablet(context)
                            ? 2
                            : 3,
                    crossAxisSpacing: 20,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      CustomFormTextField(
                        label: 'User Status',
                        isDropDown: true,
                        selectedItem: enterpriseController.userSelectedStatus,
                        dropDownItems: enterpriseController.userStatus,
                      ),
                      CustomFormTextField(
                        label: 'Enterprise name',
                        controller:
                            enterpriseController.enterpriseNameController,
                      ),
                      CustomFormTextField(
                        label: 'Enterprise Formation Date',
                        controller:
                            enterpriseController.formationDateController,
                        enabled: false,
                        suffixIcon: GestureDetector(
                            onTap: () async {
                              DateTime? newDateTime = await showDatePicker(
                                context: context,
                                initialDate: Utils.stringToDateConvertor(
                                    enterpriseController.formationDate.value),
                                firstDate: DateTime(DateTime.now().year - 90),
                                lastDate: DateTime.now(),
                              );

                              if (newDateTime != null) {
                                enterpriseController.formationDateController
                                    .text = Utils.dateConvertor(newDateTime);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.calendar_month),
                            )),
                      ),
                      CustomFormTextField(
                        label: 'Your Signatory title',
                        controller:
                            enterpriseController.signatoryTitleController,
                      ),
                      CustomFormTextField(
                        label: 'Employer Identification Number',
                        controller:
                            enterpriseController.identificationNumberController,
                      ),
                      CustomFormTextField(
                        label: 'EIN Verification',
                        isFile: true,
                        enabled: false,
                        controller:
                            enterpriseController.EINVerificationNameController,
                        suffixIcon: CommonFilePickerBtn(
                          () async {
                            int EINVerification = 1;
                            enterpriseController
                                .getDocumentsStorage(EINVerification);
                          },
                          () async {
                            if (enterpriseController
                                    .EINVerificationUrlController
                                    .text
                                    .isNotEmpty ||
                                enterpriseController
                                    .EINVerificationImgFile.value.isNotEmpty) {
                              if (enterpriseController
                                  .EINVerificationImgFile.value.isEmpty) {
                                commonPdfViewDialog(
                                  context,
                                  pdfUrl: enterpriseController
                                      .EINVerificationUrlController.text,
                                );
                              } else {
                                commonPdfViewDialog(context,
                                    memoryPdf: enterpriseController
                                        .EINVerificationImgFile.value);
                              }
                            }
                          },
                          isEyeVisible: enterpriseController
                                  .EINVerificationUrlController
                                  .text
                                  .isNotEmpty ||
                              enterpriseController
                                  .EINVerificationImgFile.value.isNotEmpty,
                        ),

                        // GestureDetector(
                        //   onTap: () async {
                        //     // print("call");
                        //
                        //     // int EINVerification = 1;
                        //     // enterpriseController
                        //     //     .getDocumentsStorage(EINVerification);
                        //   },
                        //   child: Container(
                        //     height: 43,
                        //     alignment: Alignment.center,
                        //     width: 120,
                        //     decoration: BoxDecoration(
                        //         color: Color(0xFFDADADA),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: TextWidget(
                        //       'Choose File',
                        //       fontSize: 15,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                      ),
                      CustomFormTextField(
                        label: 'Operating Agreement',
                        isFile: true,
                        enabled: false,
                        controller: enterpriseController
                            .operatingAgreementNameController,
                        suffixIcon: CommonFilePickerBtn(
                          () async {
                            int operatingAgreement = 2;
                            enterpriseController
                                .getDocumentsStorage(operatingAgreement);
                          },
                          () async {
                            if (enterpriseController
                                    .operatingAgreementUrlController
                                    .text
                                    .isNotEmpty ||
                                enterpriseController.operatingAgreementImgFile
                                    .value.isNotEmpty) {
                              if (enterpriseController
                                  .operatingAgreementImgFile.value.isEmpty) {
                                commonPdfViewDialog(
                                  context,
                                  pdfUrl: enterpriseController
                                      .operatingAgreementUrlController.text,
                                );
                              } else {
                                commonPdfViewDialog(context,
                                    memoryPdf: enterpriseController
                                        .operatingAgreementImgFile.value);
                              }
                            }
                          },
                          isEyeVisible: enterpriseController
                                  .operatingAgreementUrlController
                                  .text
                                  .isNotEmpty ||
                              enterpriseController
                                  .operatingAgreementImgFile.value.isNotEmpty,
                        ),
                      ),
                      CustomFormTextField(
                        label: 'Certificate of Formation',
                        isFile: true,
                        enabled: false,
                        controller: enterpriseController
                            .certificateOfFormationNameController,
                        suffixIcon: CommonFilePickerBtn(
                          () async {
                            int certificateOfFormation = 3;
                            enterpriseController
                                .getDocumentsStorage(certificateOfFormation);
                          },
                          () async {
                            if (enterpriseController
                                    .certificateOfFormationUrlController
                                    .text
                                    .isNotEmpty ||
                                enterpriseController
                                    .certificateOfFormationImgFile
                                    .value
                                    .isNotEmpty) {
                              if (enterpriseController
                                  .certificateOfFormationImgFile
                                  .value
                                  .isEmpty) {
                                commonPdfViewDialog(
                                  context,
                                  pdfUrl: enterpriseController
                                      .certificateOfFormationUrlController.text,
                                );
                              } else {
                                commonPdfViewDialog(context,
                                    memoryPdf: enterpriseController
                                        .certificateOfFormationImgFile.value);
                              }
                            }
                          },
                          isEyeVisible: enterpriseController
                                  .certificateOfFormationUrlController
                                  .text
                                  .isNotEmpty ||
                              enterpriseController.certificateOfFormationImgFile
                                  .value.isNotEmpty,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextWidget(
                    "Select Statement",
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 0,
                    childAspectRatio: width /
                        (defaultHeight /
                            (!Responsive.isDesktop(context)
                                ? Responsive.isMobile(context)
                                    ? 9.5
                                    : 4.5
                                : 2.5)),
                    crossAxisCount: Responsive.isMobile(context)
                        ? 1
                        : Responsive.isTablet(context)
                            ? 2
                            : 3,
                    crossAxisSpacing: 20,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      CustomMultiChooseButton(
                        buttonText: statement1,
                        onBtnPress: () {
                          if (enterpriseController.statementList
                              .contains(statement1)) {
                            enterpriseController.statementList
                                .remove(statement1);
                          } else {
                            enterpriseController.statementList.add(statement1);
                          }
                        },
                        isSelected: enterpriseController.statementList
                            .contains(statement1),
                      ),
                      CustomMultiChooseButton(
                        buttonText: statement2,
                        onBtnPress: () {
                          if (enterpriseController.statementList
                              .contains(statement2)) {
                            enterpriseController.statementList
                                .remove(statement2);
                          } else {
                            enterpriseController.statementList.add(statement2);
                          }
                        },
                        isSelected: enterpriseController.statementList
                            .contains(statement2),
                      ),
                      CustomMultiChooseButton(
                        buttonText: statement3,
                        onBtnPress: () {
                          if (enterpriseController.statementList
                              .contains(statement3)) {
                            enterpriseController.statementList
                                .remove(statement3);
                          } else {
                            enterpriseController.statementList.add(statement3);
                          }
                        },
                        isSelected: enterpriseController.statementList
                            .contains(statement3),
                      ),
                      CustomMultiChooseButton(
                        buttonText: statement4,
                        onBtnPress: () {
                          if (enterpriseController.statementList
                              .contains(statement4)) {
                            enterpriseController.statementList
                                .remove(statement4);
                          } else {
                            enterpriseController.statementList.add(statement4);
                          }
                        },
                        isSelected: enterpriseController.statementList
                            .contains(statement4),
                      ),
                      CustomMultiChooseButton(
                        buttonText: statement5,
                        onBtnPress: () {
                          if (enterpriseController.statementList
                              .contains(statement5)) {
                            enterpriseController.statementList
                                .remove(statement5);
                          } else {
                            enterpriseController.statementList.add(statement5);
                          }
                        },
                        isSelected: enterpriseController.statementList
                            .contains(statement5),
                      ),
                    ],
                  ),
                  if (enterpriseController.accountInfoCardView.isNotEmpty) ...[
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      "Bank Details",
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: width /
                              (defaultHeight /
                                  (!Responsive.isDesktop(context)
                                      ? Responsive.isMobile(context)
                                          ? 5
                                          : 2.6
                                      : 1.5)),
                          crossAxisCount: Responsive.isMobile(context)
                              ? 1
                              : Responsive.isTablet(context)
                                  ? 2
                                  : 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount:
                          enterpriseController.accountInfoCardView.length,
                      itemBuilder: (BuildContext context, int index) {
                        return commonBankAccount(
                            index + 1,
                            enterpriseController
                                    .accountInfoCardView[index].holderName ??
                                '',
                            enterpriseController
                                    .accountInfoCardView[index].accountNumber ??
                                '',
                            enterpriseController.accountInfoCardView[index]
                                    .institutionName ??
                                '');
                      },
                      // physics: NeverScrollableScrollPhysics(),
                    ),
                    if (enterpriseController
                        .transactionDataList.isNotEmpty) ...[
                      TransactionsTable(),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (enterpriseController
                                          .transactionCurrentPage.value >
                                      0)
                                    enterpriseController
                                        .transactionCurrentPage.value--;
                                },
                                child:
                                    SvgPicture.asset(Assets.svgsPreviousIcon)),
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
                              child: TextWidget((enterpriseController
                                          .transactionCurrentPage.value +
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
                              child: TextWidget((enterpriseController
                                          .transactionDataList.length /
                                      10)
                                  .ceil()
                                  .toString()),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  if ((enterpriseController
                                              .transactionCurrentPage.value +
                                          1) <
                                      (enterpriseController
                                                  .transactionDataList.length /
                                              enterpriseController
                                                  .transactionRowsPerPage.value)
                                          .ceil())
                                    enterpriseController
                                        .transactionCurrentPage.value++;
                                },
                                child: SvgPicture.asset(Assets.svgsNextIcon)),
                          ],
                        ),
                      ),
                    ],
                  ],
                  if (enterpriseController.propertyInfoCardView.isNotEmpty) ...[
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      "Property Info",
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: width /
                              (defaultHeight /
                                  (!Responsive.isDesktop(context)
                                      ? Responsive.isMobile(context)
                                          ? 2.5
                                          : 0.8
                                      : .5)),
                          crossAxisCount: Responsive.isMobile(context)
                              ? 1
                              : Responsive.isTablet(context)
                                  ? 3
                                  : 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount:
                          enterpriseController.propertyInfoCardView.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _data =
                            enterpriseController.propertyInfoCardView[index];
                        return commonProperty(
                            _data.images ?? [],
                            _data.name ?? '',
                            _data.investmentValue ?? '',
                            _data.invested ?? '',
                            _data.earns ?? '',
                            _data.returnOnInvestment ?? '',
                            Utils.timeStampToString(
                                _data.investedDate ?? Timestamp.now()),
                            _data.sold ?? '');
                      },
                      // physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
