import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/PropertyPage/Components/property_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'property_controller.dart';

class PropertyListScreen extends StatefulWidget {
  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  PropertyController propertyController = Get.find();
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
                  "Property",
                  fontSize: 25,
                ),
                Spacer(),
                CustomButton(
                  buttonText: '+ Add',
                  onBtnPress: () async {
                    // await propertyController.setSelectedPropertyData();
                    propertyController.onPropertyAdd();
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
            PropertyTable(),
            Spacer(),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        if (propertyController.propertyCurrentPage.value > 0)
                          propertyController.propertyCurrentPage.value--;
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
                        (propertyController.propertyCurrentPage.value + 1)
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
                        (propertyController.propertyDataList.length / 10)
                            .ceil()
                            .toString()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        if ((propertyController.propertyCurrentPage.value + 1) <
                            (propertyController.propertyDataList.length /
                                    propertyController
                                        .propertyRowsPerPage.value)
                                .ceil())
                          propertyController.propertyCurrentPage.value++;
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
