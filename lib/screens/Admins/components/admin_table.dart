import 'package:admin/responsive.dart';
import 'package:admin/screens/Admins/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'admin_table_data.dart';

class AdminTable extends StatelessWidget {
  AdminTable({
    Key? key,
  }) : super(key: key);

  AdminController adminController = Get.put(AdminController());

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
              sortAscending: adminController.adminIsAscending.value,
              sortColumnIndex: adminController.adminCurrentSortColumn.value,
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
                    label: Text("Questions"),
                    onSort: (columnIndex, _) {
                      adminController.adminCurrentSortColumn.value =
                          columnIndex;
                      if (adminController.adminIsAscending == true) {
                        adminController.adminIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        adminController.adminDataList
                            .sort((productA, productB) {
                          return (productB.username ?? '')
                              .compareTo(productA.username ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        adminController.adminIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        adminController.adminDataList.sort(
                            (productA, productB) => (productA.username ?? '')
                                .compareTo(productB.username ?? ''));
                      }
                    }),
                DataColumn(
                  label: Text("Actions"),
                ),
              ],
              rows: getAdminCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
