import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../users_controller.dart';
import 'user_transfer_table_data.dart';

class TransactionsTable extends StatelessWidget {
  TransactionsTable({
    Key? key,
  }) : super(key: key);

  final UsersController usersController = Get.find();

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
                : MediaQuery.of(context).size.width * .75,
            child: DataTable(
              columnSpacing: defaultPadding,
              showBottomBorder: false,
              sortAscending: usersController.transactionIsAscending.value,
              sortColumnIndex:
                  usersController.transactionCurrentSortColumn.value,
              dataRowHeight: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // border: TableBorder.all(
              //     color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              // minWidth: 600,
              columns: [
                DataColumn(label: Text("No")),
                DataColumn(
                  label: Expanded(child: Text("Property Image")),
                  // Sorting function
                ),
                DataColumn(
                    label: Expanded(child: Text("Property Name")),
                    onSort: (columnIndex, _) {
                      usersController.transactionCurrentSortColumn.value =
                          columnIndex;
                      if (usersController.transactionIsAscending == true) {
                        usersController.transactionIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.transactionDataList
                            .sort((productA, productB) {
                          return (productB.propertyName ?? '')
                              .compareTo(productA.propertyName ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.transactionIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.transactionDataList.sort(
                            (productA, productB) =>
                                (productA.propertyName ?? '')
                                    .compareTo(productB.propertyName ?? ''));
                      }
                    }),
                DataColumn(
                    label: Expanded(child: Text("Property Date")),
                    onSort: (columnIndex, _) {
                      usersController.transactionCurrentSortColumn.value =
                          columnIndex;
                      if (usersController.transactionIsAscending == true) {
                        usersController.transactionIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.transactionDataList
                            .sort((productA, productB) {
                          return (productB.date ?? '')
                              .compareTo(productA.date ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.transactionIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.transactionDataList.sort(
                            (productA, productB) => (productA.date ?? '')
                                .compareTo(productB.date ?? ''));
                      }
                    }),
                DataColumn(
                    label: Expanded(child: Text("Transfer Amount")),
                    onSort: (columnIndex, _) {
                      usersController.transactionCurrentSortColumn.value =
                          columnIndex;
                      if (usersController.transactionIsAscending == true) {
                        usersController.transactionIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.transactionDataList
                            .sort((productA, productB) {
                          return (productB.amount ?? '')
                              .compareTo(productA.amount ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.transactionIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.transactionDataList.sort(
                            (productA, productB) => (productA.amount ?? '')
                                .compareTo(productB.amount ?? ''));
                      }
                    }),
              ],
              rows: getTransferCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
