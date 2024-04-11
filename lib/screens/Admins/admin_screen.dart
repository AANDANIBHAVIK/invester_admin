import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/Admins/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'components/admin_table.dart';
import 'components/dialogBox.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen();

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminController adminController = Get.put(AdminController());

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Obx(
        () => Column(
          children: [
            Header(
              title: 'Admins',
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
              child: adminController.isLoading.value
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              "Admins",
                              fontSize: 25,
                            ),
                            Spacer(),
                            CustomButton(
                              buttonText: '+ Create',
                              onBtnPress: () async {
                                addAdminBox(Get.context!, adminController);
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
                        AdminTable(),
                        Spacer(),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (adminController.adminCurrentPage.value >
                                        0)
                                      adminController.adminCurrentPage.value--;
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
                                    (adminController.adminCurrentPage.value + 1)
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
                                    (adminController.adminDataList.length / 10)
                                        .ceil()
                                        .toString()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if ((adminController
                                                .adminCurrentPage.value +
                                            1) <
                                        (adminController.adminDataList.length /
                                                adminController
                                                    .adminRowsPerPage.value)
                                            .ceil())
                                      adminController.adminCurrentPage.value++;
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
