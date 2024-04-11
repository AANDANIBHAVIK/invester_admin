import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'Components/enterprise_table.dart';
import 'enterprise_controller.dart';

class CompaniesScreen extends StatefulWidget {
  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  EnterpriseController enterpriseController = Get.find();

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
      child: Container(
        height: 800,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                  "Latest Companies",
                  fontSize: 25,
                ),
                Spacer(),
                CustomButton(
                  buttonText: '+ Add',
                  onBtnPress: () async {
                    // await propertyController.setSelectedPropertyData();
                    enterpriseController.onUserAdd();
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
            UserTable(),
            Spacer(),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        if (enterpriseController.currentPage.value > 0)
                          enterpriseController.currentPage.value--;
                      },
                      child: SvgPicture.asset(Assets.svgsPreviousIcon)),
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
                        (enterpriseController.currentPage.value + 1)
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
                        (enterpriseController.enterpriseDataList.length / 10)
                            .ceil()
                            .toString()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        if ((enterpriseController.currentPage.value + 1) <
                            (enterpriseController.enterpriseDataList.length /
                                    enterpriseController.rowsPerPage.value)
                                .ceil())
                          enterpriseController.currentPage.value++;
                      },
                      child: SvgPicture.asset(Assets.svgsNextIcon)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
