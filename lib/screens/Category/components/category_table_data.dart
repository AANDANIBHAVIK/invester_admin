import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/Category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'dialogBox.dart';

List<DataRow> getCategoryCurrentPageData() {
  CategoryController categoryController = Get.put(CategoryController());

  DataRow categoryDataRow(String categoryInfo, int index) {
    return DataRow(
      cells: [
        DataCell(
          TextWidget(
            '$index',
            color: Colors.black,
          ),
        ),
        DataCell(
          TextWidget(
            categoryInfo ?? '-',
            color: Colors.black,
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    addCategoryBox(Get.context!, categoryController,
                        name: categoryInfo);
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () {
                      categoryController.addCategoryData(categoryInfo,
                          isDelete: true);
                    });
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsDeleteIcon,
                    color: Colors.redAccent,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  categoryController.categoryDataRowList.clear();
  int startIndex = categoryController.categoryCurrentPage.value *
      categoryController.categoryRowsPerPage.value;
  int endIndex = (startIndex + categoryController.categoryRowsPerPage.value)
      .clamp(0, categoryController.categoryDataList.length);
  // print(endIndex);
  List<String> _list =
      categoryController.categoryDataList.sublist(startIndex, endIndex);
  int index = 0;
  for (var i in _list) {
    index++;
    DataRow test = categoryDataRow(i, index);
    categoryController.categoryDataRowList.add(test);
  }
  return categoryController.categoryDataRowList;
}
