import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/Category/category_controller.dart';
import 'package:admin/screens/Category/components/category_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'components/dialogBox.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());

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
              title: 'Categories',
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
              child: categoryController.isLoading.value
                  ? SizedBox()
                  : Column(
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
                                addCategoryBox(
                                    Get.context!, categoryController);
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
                        CategoryTable(),
                        Spacer(),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (categoryController
                                            .categoryCurrentPage.value >
                                        0)
                                      categoryController
                                          .categoryCurrentPage.value--;
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
                                child: TextWidget((categoryController
                                            .categoryCurrentPage.value +
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
                                child: TextWidget((categoryController
                                            .categoryDataList.length /
                                        10)
                                    .ceil()
                                    .toString()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if ((categoryController
                                                .categoryCurrentPage.value +
                                            1) <
                                        (categoryController
                                                    .categoryDataList.length /
                                                categoryController
                                                    .categoryRowsPerPage.value)
                                            .ceil())
                                      categoryController
                                          .categoryCurrentPage.value++;
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
