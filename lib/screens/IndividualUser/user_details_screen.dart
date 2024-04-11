import 'dart:io';

import 'package:admin/Utils/Widgets/common_flie_btns.dart';
import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/image_view_dialog.dart';
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
import 'Components/common_property_detail.dart';
import 'Components/user_transactions_table.dart';
import 'users_controller.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UsersController usersController = Get.find();

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
    return Obx(
      () => usersController.isLoading.value
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
                            "UserDetails",
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
                          await usersController.setSelectedUserData();
                          // usersController.onBack();
                          // propertyController.currentSelectedScreen.value = 0;
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
                          usersController.onBack();
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
                  //   "Account Details ",
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
                                  // DecorationImage(
                                  //     image: NetworkImage(usersController
                                  //             .newUserProfile.isEmpty
                                  //         ? usersController
                                  //                 .userProfile.value.isEmpty
                                  //             ? placeHolderImg
                                  //             : usersController.userProfile.value
                                  //         : usersController.newUserProfile.value),
                                  //     fit: BoxFit.cover),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       color: Colors.grey.withOpacity(0.15),
                                  //       spreadRadius: 2,
                                  //       blurRadius: 4,
                                  //       offset: Offset(2, 2))
                                  // ]
                                  usersController
                                          .profileImgFile.value.isNotEmpty
                                      ? DecorationImage(
                                          image: MemoryImage(usersController
                                              .profileImgFile.value),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage(usersController
                                                  .userProfile.value.isEmpty
                                              ? placeHolderImg
                                              : usersController
                                                  .userProfile.value),
                                          fit: BoxFit.cover),
                            ),
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
                                        usersController.profileImgFile.value =
                                            await imageFile;
                                      }
                                    });
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
                      //   controller: usersController.userNameController,
                      // ),
                      CustomFormTextField(
                        label: 'Email *',
                        controller: usersController.userEmailController,
                      ),
                      if (usersController.selectedUserId.value.isEmpty) ...[
                        CustomFormTextField(
                          label: 'Password *',
                          controller: usersController.userPasswordController,
                        ),
                      ],
                      CustomFormTextField(
                        label: 'Phone *',
                        controller: usersController.userPhoneController,
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
                  Obx(
                    () => GridView.count(
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
                          selectedItem: usersController.userSelectedStatus,
                          dropDownItems: usersController.userStatus,
                        ),
                        CustomFormTextField(
                          label: 'Employee status',
                          isDropDown: true,
                          selectedItem: usersController.empSelectedStatus,
                          dropDownItems: usersController.empStatus,
                          onChange: (val) {
                            if (val == selfEmployed || val == employed) {
                              usersController.isEmpInfoVisible.value = true;
                            } else {
                              usersController.isEmpInfoVisible.value = false;
                            }
                          },
                          // color: Colors.white,
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        if (usersController.isEmpInfoVisible.value) ...[
                          CustomFormTextField(
                            label: 'Employee name / company',
                            controller: usersController.empNameController,
                          ),
                          CustomFormTextField(
                            label: 'Your Job Title',
                            controller: usersController.jobTitleController,
                          ),
                          CustomFormTextField(
                            label: 'Your Occupation Industry',
                            controller: usersController.occIndustryController,
                          ),
                        ],
                        CustomFormTextField(
                          label: 'Date of Birth',
                          controller: usersController.dobController,
                          enabled: false,
                          suffixIcon: GestureDetector(
                              onTap: () async {
                                DateTime? newDateTime = await showDatePicker(
                                  context: context,
                                  initialDate: Utils.stringToDateConvertor(
                                      usersController.dob.value),
                                  firstDate: DateTime(DateTime.now().year - 90),
                                  lastDate: DateTime.now(),
                                );

                                if (newDateTime != null) {
                                  usersController.dobController.text =
                                      Utils.dateConvertor(newDateTime);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.calendar_month),
                              )),
                        ),
                        CustomFormTextField(
                          label: 'Social Number',
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: usersController.socialNumberController,
                        ),
                        CustomFormTextField(
                          label: 'Enter Address',
                          controller: usersController.addressController,
                        ),
                        CustomFormTextField(
                          label: 'Enter City',
                          controller: usersController.cityController,
                        ),
                        CustomFormTextField(
                          label: 'Enter State',
                          controller: usersController.stateController,
                        ),
                        CustomFormTextField(
                          label: 'Enter Zip',
                          controller: usersController.zipController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(5),
                          ],
                        ),
                        CustomFormTextField(
                          label: 'Relationship Status',
                          isDropDown: true,
                          selectedItem: usersController.relationSelectedStatus,
                          dropDownItems: usersController.relationStatus,
                        ),
                        CustomFormTextField(
                          label: 'AMIA Account Source',
                          isDropDown: true,
                          selectedItem: usersController.AMIASelectedStatus,
                          dropDownItems: usersController.AMIAStatus,
                        ),
                        CustomFormTextField(
                          label: 'Accredited Investor',
                          isDropDown: true,
                          selectedItem:
                              usersController.accreditedSelectedStatus,
                          dropDownItems: usersController.accreditedStatus,
                        ),
                        CustomFormTextField(
                          label: 'Level Of Risk',
                          isDropDown: true,
                          selectedItem: usersController.riskSelectedStatus,
                          dropDownItems: usersController.riskStatus,
                        ),
                        CustomFormTextField(
                          label: 'Employee By Associated',
                          isDropDown: true,
                          selectedItem: usersController.stockSelectedStatus,
                          dropDownItems: usersController.stockStatus,
                        ),
                        CustomFormTextField(
                          label: 'Politically Exposed Person',
                          isDropDown: true,
                          selectedItem:
                              usersController.isPoliticalSelectedStatus,
                          dropDownItems: usersController.politicalStatus,
                        ),
                        // CustomFormTextField(
                        //   label: 'Document Type',
                        //   isDropDown: true,
                        //   selectedItem: usersController.documentSelectedStatus,
                        //   dropDownItems: usersController.documentStatus,
                        // ),
                        CustomFormTextField(
                          label: 'Driving License',
                          isFile: true,
                          enabled: false,
                          controller:
                              usersController.drivingLicenseNameController,
                          suffixIcon: CommonFilePickerBtn(() async {
                            int drivingLicenseId = 0;
                            usersController
                                .uploadDocumentImage(drivingLicenseId);
                          }, () async {
                            if (usersController.drivingLicenseUrlController.text
                                    .isNotEmpty ||
                                usersController
                                    .drivingLicenseImgFile.value.isNotEmpty) {
                              if (usersController
                                  .drivingLicenseImgFile.value.isEmpty) {
                                commonImageViewDialog(context,
                                    imageUrl: usersController
                                        .drivingLicenseUrlController.text);
                              } else {
                                commonImageViewDialog(
                                  context,
                                  memoryImage: usersController
                                      .drivingLicenseImgFile.value,
                                );
                              }
                            }
                          },
                              isEyeVisible: usersController
                                      .drivingLicenseUrlController
                                      .text
                                      .isNotEmpty ||
                                  usersController
                                      .drivingLicenseImgFile.value.isNotEmpty),
                        ),
                        CustomFormTextField(
                          label: 'Social Security',
                          isFile: true,
                          enabled: false,
                          controller: usersController.socialCardNameController,
                          suffixIcon: CommonFilePickerBtn(
                            () async {
                              int socialSecurityId = 1;
                              usersController
                                  .uploadDocumentImage(socialSecurityId);
                            },
                            () async {
                              if (usersController.socialCardUrlController.text
                                      .isNotEmpty ||
                                  usersController
                                      .socialCardImgFile.value.isNotEmpty) {
                                if (usersController
                                    .socialCardImgFile.value.isEmpty) {
                                  commonImageViewDialog(context,
                                      imageUrl: usersController
                                          .socialCardUrlController.text);
                                } else {
                                  commonImageViewDialog(
                                    context,
                                    memoryImage:
                                        usersController.socialCardImgFile.value,
                                  );
                                }
                              }
                            },
                            isEyeVisible: usersController
                                    .socialCardUrlController.text.isNotEmpty ||
                                usersController
                                    .socialCardImgFile.value.isNotEmpty,
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () async {
                          //         int socialSecurityId = 1;
                          //         usersController
                          //             .uploadDocumentImage(socialSecurityId);
                          //       },
                          //       child: Container(
                          //         height: 43,
                          //         alignment: Alignment.center,
                          //         width: 55,
                          //         decoration: BoxDecoration(
                          //             color: Color(0xFFD7D7D7),
                          //             borderRadius: BorderRadius.circular(0)),
                          //         child: RotatedBox(
                          //           quarterTurns: 1,
                          //           child: SvgPicture.asset(
                          //             Assets.svgsLogout,
                          //             color: Colors.black,
                          //             height: 22,
                          //             width: 22,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () async {
                          //         if (usersController.socialCardUrlController
                          //                 .text.isNotEmpty ||
                          //             usersController.socialCardImgFile.value
                          //                 .isNotEmpty) {
                          //           if (usersController
                          //               .socialCardImgFile.value.isEmpty) {
                          //             commonImageViewDialog(context,
                          //                 imageUrl: usersController
                          //                     .socialCardUrlController.text);
                          //           } else {
                          //             commonImageViewDialog(
                          //               context,
                          //               memoryImage: usersController
                          //                   .socialCardImgFile.value,
                          //             );
                          //           }
                          //         }
                          //       },
                          //       child: Container(
                          //         height: 43,
                          //         alignment: Alignment.center,
                          //         width: 55,
                          //         decoration: BoxDecoration(
                          //             color: Color(0xFFD7D7D7),
                          //             borderRadius: BorderRadius.only(
                          //                 topRight: Radius.circular(10),
                          //                 bottomRight: Radius.circular(10))),
                          //         child: SvgPicture.asset(
                          //           Assets.svgsEyeIcon,
                          //           color: usersController
                          //                       .socialCardUrlController
                          //                       .text
                          //                       .isNotEmpty ||
                          //                   usersController.socialCardImgFile
                          //                       .value.isNotEmpty
                          //               ? Colors.black
                          //               : Colors.black.withOpacity(0.7),
                          //           height: 18,
                          //           width: 18,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ),
                      ],
                    ),
                  ),
                  if (usersController.accountInfoCardView.isNotEmpty) ...[
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
                      itemCount: usersController.accountInfoCardView.length,
                      itemBuilder: (BuildContext context, int index) {
                        return commonBankAccount(
                            index + 1,
                            usersController
                                    .accountInfoCardView[index].holderName ??
                                '',
                            usersController
                                    .accountInfoCardView[index].accountNumber ??
                                '',
                            usersController.accountInfoCardView[index]
                                    .institutionName ??
                                '');
                      },
                      // physics: NeverScrollableScrollPhysics(),
                    ),
                    if (usersController.transactionDataList.isNotEmpty) ...[
                      TransactionsTable(),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (usersController
                                          .transactionCurrentPage.value >
                                      0)
                                    usersController
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
                              child: TextWidget((usersController
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
                              child: TextWidget(
                                  (usersController.transactionDataList.length /
                                          10)
                                      .ceil()
                                      .toString()),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  if ((usersController
                                              .transactionCurrentPage.value +
                                          1) <
                                      (usersController
                                                  .transactionDataList.length /
                                              usersController
                                                  .transactionRowsPerPage.value)
                                          .ceil())
                                    usersController
                                        .transactionCurrentPage.value++;
                                },
                                child: SvgPicture.asset(Assets.svgsNextIcon)),
                          ],
                        ),
                      ),
                    ],
                  ],
                  if (usersController.propertyInfoCardView.isNotEmpty) ...[
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
                      itemCount: usersController.propertyInfoCardView.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _data = usersController.propertyInfoCardView[index];
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
