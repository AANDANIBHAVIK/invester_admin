import 'dart:html' as html;
import 'dart:io';

import 'package:admin/Utils/Widgets/common_flie_btns.dart';
import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/Utils/Widgets/pdf_view_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/Utils/utils.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/Settings/settings_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dialogBox.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());

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
    return Column(
      children: [
        Header(
          title: 'Settings',
        ),
        Obx(
          () => settingController.isLoading.value
              ? Container()
              : Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.all(25),
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
                                    "App Settings",
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
                                  await settingController.setDataToFirebase();
                                  // usersController.onBack();
                                  // settingController.currentSelectedScreen.value = 0;
                                },
                                width: 10,
                                height: 4,
                                fontSize: 15,
                                borderRadius: 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // CustomButton(
                              //   buttonText: 'Back',
                              //   onBtnPress: () {
                              //     // usersController.onBack();
                              //   },
                              //   width: Responsive.isMobile(context) ? 13 : 10,
                              //   height: 4,
                              //   fontSize: 15,
                              //   borderRadius: 5,
                              // ),
                            ],
                          ),
                          Divider(),
                          TextWidget(
                            "PlaceHolder Image",
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
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
                                      image: settingController
                                              .placeholderImgFile
                                              .value
                                              .isNotEmpty
                                          ? DecorationImage(
                                              image: MemoryImage(
                                                  settingController
                                                      .placeholderImgFile
                                                      .value),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: NetworkImage(settingController
                                                      .placeholderUrlController
                                                      .text
                                                      .isEmpty
                                                  ? placeHolderImg
                                                  : settingController
                                                      .placeholderUrlController
                                                      .text),
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: InkWell(
                                        onTap: () async {
                                          var result = await FilePicker.platform
                                              .pickFiles(
                                            allowMultiple: false,
                                            type: FileType.image,
                                          );
                                          if (result == null) {
                                            print("No file selected");
                                          } else {
                                            result.files
                                                .forEach((element) async {
                                              Uint8List? imageFile =
                                                  element.bytes;
                                              if (imageFile == null &&
                                                  element.path != null) {
                                                imageFile =
                                                    await convertXFileToUint8List(
                                                        File(element.path!));
                                              }
                                              if (imageFile != null) {
                                                settingController
                                                    .placeholderImgFile
                                                    .value = await imageFile;
                                                settingController
                                                    .placeholderNameController
                                                    .text = element.name;
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
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
                          TextWidget(
                            "Agreements",
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
                                            ? 2.8
                                            : 1.45
                                        : 0.8)),
                            crossAxisCount: Responsive.isMobile(context)
                                ? 1
                                : Responsive.isTablet(context)
                                    ? 2
                                    : 3,
                            crossAxisSpacing: 20,
                            // physics: NeverScrollableScrollPhysics(),
                            children: [
                              CustomFormTextField(
                                label: 'Operating Agreement',
                                controller: settingController
                                    .operatingAgreementController,
                                maxLine: 10,
                                textInputType: TextInputType.multiline,
                              ),
                              CustomFormTextField(
                                label: 'Secondary Listing Agreement',
                                controller: settingController
                                    .secondaryListingAgreementController,
                                maxLine: 10,
                                textInputType: TextInputType.multiline,
                              ),
                              CustomFormTextField(
                                label: 'Securities Transfer Agreement',
                                controller: settingController
                                    .securitiesTransferAgreementController,
                                maxLine: 10,
                                textInputType: TextInputType.multiline,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                "More about accredited investor :",
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomFormTextField(
                                label: 'Document Image',
                                isFile: true,
                                enabled: false,
                                controller:
                                    settingController.documentNameController,
                                suffixIcon: CommonFilePickerBtn(
                                  () async {
                                    settingController.getDocumentsStorage();
                                  },
                                  () async {
                                    if (settingController.documentUrlController
                                            .text.isNotEmpty ||
                                        settingController
                                            .documentImgFile.value.isNotEmpty) {
                                      if (settingController
                                          .documentImgFile.value.isEmpty) {
                                        commonPdfViewDialog(
                                          context,
                                          pdfUrl: settingController
                                              .documentUrlController.text,
                                        );
                                      } else {
                                        commonPdfViewDialog(context,
                                            memoryPdf: settingController
                                                .documentImgFile.value);
                                      }
                                    }
                                  },
                                  isEyeVisible: settingController
                                          .documentUrlController
                                          .text
                                          .isNotEmpty ||
                                      settingController
                                          .documentImgFile.value.isNotEmpty,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              TextWidget(
                                "Plaid Account",
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
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
                                crossAxisCount:
                                    Responsive.isMobile(context) ? 1 : 2,
                                crossAxisSpacing: 20,
                                // physics: NeverScrollableScrollPhysics(),
                                children: [
                                  CustomFormTextField(
                                    label: 'Client Id',
                                    controller:
                                        settingController.clientIdController,
                                  ),
                                  CustomFormTextField(
                                    label: 'Secrets key',
                                    controller:
                                        settingController.secretsKeyController,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                "Document's Url",
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
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
                                crossAxisCount:
                                    Responsive.isMobile(context) ? 1 : 2,
                                crossAxisSpacing: 20,
                                // physics: NeverScrollableScrollPhysics(),
                                children: [
                                  CustomFormTextField(
                                    label: 'Privacy Policy',
                                    controller: settingController
                                        .privacyPolicyController,
                                  ),
                                  CustomFormTextField(
                                    label: 'Customer Support',
                                    controller: settingController
                                        .customerSupportController,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextWidget(
                            "How It Work Videos",
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
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 16 / 9,
                                      crossAxisCount:
                                          Responsive.isMobile(context)
                                              ? 1
                                              : Responsive.isTablet(context)
                                                  ? 2
                                                  : 3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount:
                                  settingController.howToWorkVideoList.length +
                                      1,
                              itemBuilder: (BuildContext context, int index) {
                                if (settingController
                                        .howToWorkVideoList.length !=
                                    index) {
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.all(15),
                                        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://img.youtube.com/vi/${Utils.convertUrlToId(settingController.howToWorkVideoList[index])}/0.jpg"),
                                                fit: BoxFit.cover),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // image: DecorationImage(
                                            //     image: NetworkImage(widget.videoUrl), fit: BoxFit.cover),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.15),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: Offset(2, 2))
                                            ]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: InkWell(
                                              onTap: () {
                                                html.window.open(
                                                    settingController
                                                            .howToWorkVideoList[
                                                        index],
                                                    "_blank");
                                                // playYoutubeLinkBox2(
                                                //     context,
                                                //     settingController
                                                //             .howToWorkVideoList[
                                                //         index]);
                                              },
                                              child: Icon(
                                                Icons.play_circle_fill_rounded,
                                                size: 100,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: GestureDetector(
                                            onTap: () {
                                              settingController
                                                  .howToWorkVideoList
                                                  .remove(settingController
                                                          .howToWorkVideoList[
                                                      index]);
                                            },
                                            child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color:
                                                            Colors.redAccent),
                                                    color: Colors.white),
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: Colors.redAccent,
                                                  size: 25,
                                                ))),
                                      ),
                                    ],
                                  );
                                  //  commonSettingVideo(
                                  //     settingController
                                  //         .howToWorkVideoList[index],
                                  //     () async {
                                  //   // await StorageMethod()
                                  //   //     .deleteDocumentToStorage(_video);
                                  //
                                  //   settingController.howToWorkVideoList
                                  //       .remove(settingController
                                  //           .howToWorkVideoList[index]);
                                  //
                                  //   // List<String> _tempList = settingController
                                  //   //         .howToWorkVideoList ??
                                  //   //     [];
                                  //   // print(_tempList);
                                  //   // settingController
                                  //   //     .howToWorkVideoList.value.clear();
                                  //   // print(settingController
                                  //   //     .howToWorkVideoList.value);
                                  //   // settingController
                                  //   //     .howToWorkVideoList.value = _tempList;
                                  //   // print(settingController
                                  //   //     .howToWorkVideoList.value);
                                  //   // print('object');
                                  // });
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      TextEditingController
                                          textEditingController =
                                          TextEditingController();
                                      addYoutubeLinkBox2(
                                          context,
                                          settingController,
                                          textEditingController);
                                      // settingController.uploadVideoFirebase();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Assets.iconsAddMoreIcon),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextWidget(
                                          "Add Video",
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
                            height: 20,
                          ),
                          CustomFormTextField(
                            label: 'How It Work Description',
                            controller: settingController.contentController,
                            maxLine: 5,
                            textInputType: TextInputType.multiline,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
