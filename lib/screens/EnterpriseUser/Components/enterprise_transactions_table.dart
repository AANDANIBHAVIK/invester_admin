import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../enterprise_controller.dart';
import 'enterprise_transfer_table_data.dart';

class TransactionsTable extends StatelessWidget {
  TransactionsTable({
    Key? key,
  }) : super(key: key);

  final EnterpriseController enterpriseController = Get.find();

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
              sortAscending: enterpriseController.transactionIsAscending.value,
              sortColumnIndex:
                  enterpriseController.transactionCurrentSortColumn.value,
              dataRowHeight: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // border: TableBorder.all(
              //     color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              // minWidth: 600,
              columns: [
                DataColumn(label: Text("No")),
                DataColumn(
                  label: Text("Property Image"),
                  // Sorting function
                ),
                DataColumn(
                    label: Text("Property Name"),
                    onSort: (columnIndex, _) {
                      enterpriseController.transactionCurrentSortColumn.value =
                          columnIndex;
                      if (enterpriseController.transactionIsAscending == true) {
                        enterpriseController.transactionIsAscending.value =
                            false;
                        // sort the product list in Ascending, order by Price
                        enterpriseController.transactionDataList
                            .sort((productA, productB) {
                          return (productB.propertyName ?? '')
                              .compareTo(productA.propertyName ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        enterpriseController.transactionIsAscending.value =
                            true;
                        // // sort the product list in Descending, order by Price
                        enterpriseController.transactionDataList.sort(
                            (productA, productB) =>
                                (productA.propertyName ?? '')
                                    .compareTo(productB.propertyName ?? ''));
                      }
                    }),
                DataColumn(
                    label: Text("Property Date"),
                    onSort: (columnIndex, _) {
                      enterpriseController.transactionCurrentSortColumn.value =
                          columnIndex;
                      if (enterpriseController.transactionIsAscending == true) {
                        enterpriseController.transactionIsAscending.value =
                            false;
                        // sort the product list in Ascending, order by Price
                        enterpriseController.transactionDataList
                            .sort((productA, productB) {
                          return (productB.date ?? '')
                              .compareTo(productA.date ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        enterpriseController.transactionIsAscending.value =
                            true;
                        // // sort the product list in Descending, order by Price
                        enterpriseController.transactionDataList.sort(
                            (productA, productB) => (productA.date ?? '')
                                .compareTo(productB.date ?? ''));
                      }
                    }),
                DataColumn(
                    label: Text("Transfer Amount"),
                    onSort: (columnIndex, _) {
                      enterpriseController.transactionCurrentSortColumn.value =
                          columnIndex;
                      if (enterpriseController.transactionIsAscending == true) {
                        enterpriseController.transactionIsAscending.value =
                            false;
                        // sort the product list in Ascending, order by Price
                        enterpriseController.transactionDataList
                            .sort((productA, productB) {
                          return (productB.amount ?? '')
                              .compareTo(productA.amount ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        enterpriseController.transactionIsAscending.value =
                            true;
                        // // sort the product list in Descending, order by Price
                        enterpriseController.transactionDataList.sort(
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
