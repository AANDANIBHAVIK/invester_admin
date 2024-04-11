import 'dart:html' as html;

import 'package:admin/Data/Resources/storage_method.dart';
import 'package:admin/Utils/Widgets/common_flie_btns.dart';
import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/pdf_view_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/Utils/utils.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/PropertyPage/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Components/common_property_image.dart';
import 'Components/dialogBox.dart';

class PropertyDetailsScreen extends StatefulWidget {
  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  PropertyController propertyController = Get.find();

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    print(propertyController.selectedPropertyId.value);
    await propertyController.getCategoryList();
    await propertyController.getCompanyList();
  }

  @override
  void dispose() {
    // propertyController.currentSelectedScreen.value = 0;
    // propertyController.onBack();
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // print("${width} + ${height}");
    return Obx(
      () => propertyController.isLoading.value
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
              child: Form(
                key: propertyController.propertyFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              "Property Details",
                              fontSize: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // TextWidget(
                            //   'Sold ${propertyController.soldValue.value}%',
                            //   color: Colors.green,
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.w700,
                            // ),
                          ],
                        ),
                        Spacer(),
                        CustomButton(
                          buttonText: 'Save',
                          onBtnPress: () async {
                            await propertyController.setSelectedPropertyData();
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
                            propertyController.onBack();
                          },
                          width: 10,
                          height: 4,
                          fontSize: 15,
                          borderRadius: 5,
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      "Images *",
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
                          childAspectRatio: 1,
                          crossAxisCount: Responsive.isMobile(context)
                              ? 1
                              : Responsive.isTablet(context)
                                  ? 3
                                  : 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: propertyController.propertyImgList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (propertyController.propertyImgList.length !=
                            index) {
                          String _image =
                              propertyController.propertyImgList[index];
                          return commonPropertyImage(_image, () async {
                            await StorageMethod()
                                .deleteDocumentToStorage(_image);
                            propertyController.propertyImgList.remove(_image);
                            print('object');
                          });
                        } else {
                          return InkWell(
                            onTap: () {
                              propertyController.uploadImageFirebase();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Assets.iconsAddMoreIcon),
                                SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                  "Add Project Image",
                                  fontSize: 23,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      // physics: NeverScrollableScrollPhysics(),
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
                          label: 'Category *',
                          isDropDown: true,
                          selectedItem:
                              propertyController.categorySelectedStatus,
                          dropDownItems: propertyController.categoryStatus,
                        ),
                        CustomFormTextField(
                          label: 'Company *',
                          isDropDown: true,
                          selectedItem:
                              propertyController.companySelectedStatus,
                          dropDownItemsMap: propertyController.companyStatus,
                        ),
                        CustomFormTextField(
                          label: 'Offer Timing *',
                          isDropDown: true,
                          selectedItem: propertyController.offerSelectedStatus,
                          dropDownItems: propertyController.offerStatus,
                        ),
                        CustomFormTextField(
                          label: 'Offer Type *',
                          isDropDown: true,
                          selectedItem: propertyController.statusSelectedStatus,
                          dropDownItems: propertyController.statusStatus,
                        ),
                        CustomFormTextField(
                          label: 'Street *',
                          controller: propertyController.streetController,
                        ),
                        CustomFormTextField(
                          label: 'City *',
                          controller: propertyController.cityController,
                        ),
                        CustomFormTextField(
                          label: 'Zip Code *',
                          controller: propertyController.zipCodeController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                        CustomFormTextField(
                          label: 'State *',
                          controller: propertyController.countryController,
                        ),
                        CustomFormTextField(
                          label: 'Invest Per Month *',
                          controller:
                              propertyController.investPerMonthController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                        // CustomFormTextField(
                        //   label: 'Bundle *',
                        //   controller: propertyController.bundleController,
                        // ),
                        CustomFormTextField(
                          label: 'Number of Units *',
                          controller: propertyController.uniteController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                        CustomFormTextField(
                          label: 'Current Investment Value *',
                          controller: propertyController.investPriceController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                        CustomFormTextField(
                          label: 'Property Title *',
                          controller:
                              propertyController.propertyTitleController,
                        ),
                        CustomFormTextField(
                          label: 'Final Value *',
                          controller:
                              propertyController.propertyFinalValController,
                        ),
                      ],
                    ),
                    CustomFormTextField(
                      label: 'Property Description *',
                      controller: propertyController.propertyDocController,
                      textInputType: TextInputType.multiline,
                      maxLine: 7,
                    ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // TextWidget(
                    //   "March Dividends *",
                    //   fontSize: 23,
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   mainAxisSpacing: 0,
                    //   childAspectRatio: width /
                    //       (defaultHeight /
                    //           (!Responsive.isDesktop(context)
                    //               ? Responsive.isMobile(context)
                    //                   ? 9.5
                    //                   : 4.5
                    //               : 2.5)),
                    //   crossAxisCount: Responsive.isMobile(context)
                    //       ? 1
                    //       : Responsive.isTablet(context)
                    //           ? 2
                    //           : 3,
                    //   crossAxisSpacing: 20,
                    //   // physics: NeverScrollableScrollPhysics(),
                    //   children: [
                    //     CustomFormTextField(
                    //       label: 'Annual Rental Collection *',
                    //       controller: propertyController.annualRentalController,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    //       ],
                    //     ),
                    //     CustomFormTextField(
                    //       label: 'Cap Rate *',
                    //       controller: propertyController.devCapRateController,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    //       ],
                    //     ),
                    //     CustomFormTextField(
                    //       label: 'After Development Value *',
                    //       controller:
                    //           propertyController.afterDevValueController,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    //       ],
                    //     ),
                    //     CustomFormTextField(
                    //       label: 'Construction Finish Date *',
                    //       controller:
                    //           propertyController.dispositionDateController,
                    //       enabled: false,
                    //       suffixIcon: GestureDetector(
                    //           onTap: () async {
                    //             DateTime? newDateTime = await showDatePicker(
                    //               context: context,
                    //               initialDate: Utils.stringToDateConvertor(
                    //                   propertyController.dispositionDate.value),
                    //               firstDate: DateTime(DateTime.now().year - 90),
                    //               lastDate: DateTime(DateTime.now().year + 90),
                    //             );
                    //
                    //             if (newDateTime != null) {
                    //               propertyController.dispositionDateController
                    //                   .text = Utils.dateConvertor(newDateTime);
                    //             }
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(right: 15),
                    //             child: Icon(Icons.calendar_month),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      "About Shares",
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
                          label: 'Each Share Value *',
                          controller: propertyController.perShareController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                        CustomFormTextField(
                          label: 'Total Shares *',
                          controller: propertyController.shareLeftController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                        ),
                        CustomFormTextField(
                          label: 'Average purchase *',
                          controller:
                              propertyController.averagePurchaseController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      "Project Presentation *",
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
                            childAspectRatio: 16 / 9,
                            crossAxisCount: Responsive.isMobile(context)
                                ? 1
                                : Responsive.isTablet(context)
                                    ? 2
                                    : 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount:
                            propertyController.propertyVideoList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (propertyController.propertyVideoList.length !=
                              index) {
                            String _video =
                                propertyController.propertyVideoList[index];

                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  // margin: const EdgeInsets.all(15),
                                  // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      // image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://img.youtube.com/vi/${Utils.convertUrlToId(propertyController.propertyVideoList[index])}/0.jpg"),
                                      //     fit: BoxFit.cover),
                                      // image: DecorationImage(
                                      //     image: NetworkImage(widget.videoUrl), fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: Offset(2, 2))
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      children: [
                                        FutureBuilder(
                                          future: precacheImage(
                                              NetworkImage(
                                                  "https://img.youtube.com/vi/${Utils.convertUrlToId(propertyController.propertyVideoList[index])}/0.jpg"),
                                              context),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: Image.network(
                                                  "https://img.youtube.com/vi/${Utils.convertUrlToId(propertyController.propertyVideoList[index])}/0.jpg",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.network(
                                                        placeHolderImg,
                                                        fit: BoxFit.cover);
                                                  },
                                                ),
                                              );
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.none) {
                                              return Text(
                                                  "Failed to load image.");
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                        // Image.network(
                                        //     'https://img.youtube.com/vi/${Utils.convertUrlToId(propertyController.propertyVideoList[index])}/0.jpg'),
                                        AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: InkWell(
                                            onTap: () {
                                              html.window.open(
                                                  propertyController
                                                      .propertyVideoList[index],
                                                  "_blank");
                                              // playYoutubeLinkBox2(context,
                                              //     'https://www.youtube.com/watch?v=lNdOtlpmH5U');
                                            },
                                            child: Icon(
                                              Icons.play_circle_fill_rounded,
                                              size: 100,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: GestureDetector(
                                      onTap: () {
                                        propertyController.propertyVideoList
                                            .remove(propertyController
                                                .propertyVideoList[index]);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.redAccent),
                                              color: Colors.white),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.redAccent,
                                            size: 25,
                                          ))),
                                ),
                              ],
                            );

                            //   commonPropertyVideo(_video, () async {
                            //   // await StorageMethod()
                            //   //     .deleteDocumentToStorage(_video);
                            //   propertyController.propertyVideoList
                            //       .remove(_video);
                            //   print('object');
                            // });
                          } else {
                            return InkWell(
                              onTap: () {
                                TextEditingController textEditingController =
                                    TextEditingController();
                                addYoutubeLinkBox(context, propertyController,
                                    textEditingController);
                                // propertyController.uploadVideoFirebase();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Assets.iconsAddMoreIcon),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextWidget(
                                    "Add Project Video",
                                    fontSize: 23,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            );
                          }

                          // physics: NeverScrollableScrollPhysics(),
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      "Documents",
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
                      children: [
                        CustomFormTextField(
                          label: 'Cash & Financing',
                          isFile: true,
                          enabled: false,
                          controller:
                              propertyController.cashFinancingNameController,
                          suffixIcon: CommonFilePickerBtn(
                            () async {
                              int cashFinanceNumber = 1;
                              propertyController
                                  .getDocumentsStorage(cashFinanceNumber);
                            },
                            () async {
                              if (propertyController.cashFinancingUrlController
                                      .text.isNotEmpty ||
                                  propertyController
                                      .cashFinancingFile.value.isNotEmpty) {
                                if (propertyController
                                    .cashFinancingFile.value.isEmpty) {
                                  commonPdfViewDialog(
                                    context,
                                    pdfUrl: propertyController
                                        .cashFinancingUrlController.text,
                                  );
                                } else {
                                  commonPdfViewDialog(context,
                                      memoryPdf: propertyController
                                          .cashFinancingFile.value);
                                }
                              }
                            },
                            isEyeVisible: propertyController
                                    .cashFinancingUrlController
                                    .text
                                    .isNotEmpty ||
                                propertyController
                                    .cashFinancingFile.value.isNotEmpty,
                          ),
                          // GestureDetector(
                          //   onTap: () async {
                          //     // print("call");
                          //     int cashFinanceNumber = 1;
                          //     propertyController
                          //         .getDocumentsStorage(cashFinanceNumber);
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
                          label: 'Property Details',
                          isFile: true,
                          enabled: false,
                          controller:
                              propertyController.propertyDetailsNameController,
                          suffixIcon: CommonFilePickerBtn(
                            () async {
                              int propertyDetailNumber = 2;
                              propertyController
                                  .getDocumentsStorage(propertyDetailNumber);
                            },
                            () async {
                              if (propertyController
                                      .propertyDetailsUrlController
                                      .text
                                      .isNotEmpty ||
                                  propertyController
                                      .propertyDetailsFile.value.isNotEmpty) {
                                if (propertyController
                                    .propertyDetailsFile.value.isEmpty) {
                                  commonPdfViewDialog(
                                    context,
                                    pdfUrl: propertyController
                                        .propertyDetailsUrlController.text,
                                  );
                                } else {
                                  commonPdfViewDialog(context,
                                      memoryPdf: propertyController
                                          .propertyDetailsFile.value);
                                }
                              }
                            },
                            isEyeVisible: propertyController
                                    .propertyDetailsUrlController
                                    .text
                                    .isNotEmpty ||
                                propertyController
                                    .propertyDetailsFile.value.isNotEmpty,
                          ),
                        ),
                        CustomFormTextField(
                          label: 'Documents',
                          isFile: true,
                          enabled: false,
                          controller:
                              propertyController.documentsNameController,
                          suffixIcon: CommonFilePickerBtn(
                            () async {
                              int documentNumber = 3;
                              propertyController
                                  .getDocumentsStorage(documentNumber);
                            },
                            () async {
                              if (propertyController
                                      .documentsUrlController.text.isNotEmpty ||
                                  propertyController
                                      .documentsFile.value.isNotEmpty) {
                                if (propertyController
                                    .documentsFile.value.isEmpty) {
                                  commonPdfViewDialog(
                                    context,
                                    pdfUrl: propertyController
                                        .documentsUrlController.text,
                                  );
                                } else {
                                  commonPdfViewDialog(context,
                                      memoryPdf: propertyController
                                          .documentsFile.value);
                                }
                              }
                            },
                            isEyeVisible: propertyController
                                    .documentsUrlController.text.isNotEmpty ||
                                propertyController
                                    .documentsFile.value.isNotEmpty,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // TextWidget(
                    //   "Project Metrics",
                    //   fontSize: 23,
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   mainAxisSpacing: 0,
                    //   childAspectRatio: width /
                    //       (defaultHeight /
                    //           (!Responsive.isDesktop(context)
                    //               ? Responsive.isMobile(context)
                    //                   ? 9.5
                    //                   : 4.5
                    //               : 2.5)),
                    //   crossAxisCount: Responsive.isMobile(context)
                    //       ? 1
                    //       : Responsive.isTablet(context)
                    //           ? 2
                    //           : 3,
                    //   crossAxisSpacing: 20,
                    //   // physics: NeverScrollableScrollPhysics(),
                    //   children: [
                    //     CustomFormTextField(
                    //       label: 'After Development ARC *',
                    //       controller: propertyController.afterARCController,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    //       ],
                    //     ),
                    //     CustomFormTextField(
                    //       label: 'After Development Cap Rate *',
                    //       controller: propertyController.afterDevCapController,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    //       ],
                    //     ),
                    //     CustomFormTextField(
                    //       label: 'After Development Value *',
                    //       controller:
                    //           propertyController.projectMetricsDevValController,
                    //       inputFormatters: <TextInputFormatter>[
                    //         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    //       ],
                    //     ),
                    //     CustomFormTextField(
                    //       label: 'Estimated Disposition date *',
                    //       controller: propertyController
                    //           .estimateDispositionDateController,
                    //       enabled: false,
                    //       suffixIcon: GestureDetector(
                    //           onTap: () async {
                    //             DateTime? newDateTime = await showDatePicker(
                    //               context: context,
                    //               initialDate: Utils.stringToDateConvertor(
                    //                   propertyController
                    //                       .estimateDispositionDate.value),
                    //               firstDate: DateTime(DateTime.now().year - 90),
                    //               lastDate: DateTime(DateTime.now().year + 90),
                    //             );
                    //
                    //             if (newDateTime != null) {
                    //               propertyController
                    //                   .estimateDispositionDateController
                    //                   .text = Utils.dateConvertor(newDateTime);
                    //             }
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(right: 15),
                    //             child: Icon(Icons.calendar_month),
                    //           )),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
