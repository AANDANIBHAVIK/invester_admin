import 'package:admin/responsive.dart';
import 'package:admin/screens/Category/category_controller.dart';
import 'package:admin/screens/Category/components/category_table_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class CategoryTable extends StatelessWidget {
  CategoryTable({
    Key? key,
  }) : super(key: key);

  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: !Responsive.isDesktop(context)
                ? Responsive.isTablet(context)
                    ? 1100
                    : 800
                : MediaQuery.of(context).size.width * .74,
            child: DataTable(
              columnSpacing: defaultPadding,
              showBottomBorder: false,
              sortAscending: categoryController.categoryIsAscending.value,
              sortColumnIndex:
                  categoryController.categoryCurrentSortColumn.value,
              dataRowHeight: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // border: TableBorder.all(
              //     color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("No"),
                ),
                DataColumn(
                    label: Text("Categories"),
                    onSort: (columnIndex, _) {
                      categoryController.categoryCurrentSortColumn.value =
                          columnIndex;
                      if (categoryController.categoryIsAscending == true) {
                        categoryController.categoryIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        categoryController.categoryDataList
                            .sort((productA, productB) {
                          return (productB).compareTo(productA);
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        categoryController.categoryIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        categoryController.categoryDataList.sort(
                            (productA, productB) =>
                                (productA).compareTo(productB));
                      }
                    }),
                DataColumn(
                  label: Text("Actions"),
                ),
              ],
              rows: getCategoryCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
