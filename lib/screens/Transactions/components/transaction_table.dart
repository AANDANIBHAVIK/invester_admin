import 'package:admin/Data/Models/transfers_model.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/Utils/utils.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/Transactions/transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class TransactionTable extends StatelessWidget {
  TransactionTable({
    Key? key,
  }) : super(key: key);

  final TransactionController transactionController = Get.find();
  List<DataRow> dataRowList = [];

  List<DataRow> getCurrentPageData() {
    dataRowList.clear();
    int startIndex = transactionController.currentPage.value *
        transactionController.rowsPerPage.value;
    int endIndex = (startIndex + transactionController.rowsPerPage.value)
        .clamp(0, transactionController.transferDataList.length);
    // print(endIndex);
    List<Transfers> _list =
        transactionController.transferDataList.sublist(startIndex, endIndex);

    for (var i in _list) {
      DataRow test = recentFileDataRow(i);
      dataRowList.add(test);
    }
    return dataRowList;
  }

  @override
  Widget build(BuildContext context) {
    print('++++++++++++++++++++++++++');
    print(transactionController.transferDataList.length);
    print(transactionController.currentPage.value <=
        (transactionController.transferDataList.length /
                transactionController.rowsPerPage.value)
            .ceil());
    print((transactionController.transferDataList.length /
            transactionController.rowsPerPage.value)
        .ceil());
    print('++++++++++++++++++++++++++');
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Recent Files",
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: !Responsive.isDesktop(context)
                    ? Responsive.isTablet(context)
                        ? 1100
                        : 800
                    : MediaQuery.of(context).size.width * .8,
                child: DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                        label: Text("TYPE"),
                        onSort: (columnIndex, _) {
                          transactionController
                              .transferCurrentSortColumn.value = columnIndex;
                          if (transactionController.transferIsAscending ==
                              true) {
                            transactionController.transferIsAscending.value =
                                false;
                            // sort the product list in Ascending, order by Price
                            transactionController.transferDataList
                                .sort((productA, productB) {
                              return (productB.type ?? '')
                                  .compareTo(productA.type ?? '');
                            });
                            // productB['price'].compareTo(productA['price']));
                          } else {
                            transactionController.transferIsAscending.value =
                                true;
                            // // sort the product list in Descending, order by Price
                            transactionController.transferDataList.sort(
                                (productA, productB) => (productA.type ?? '')
                                    .compareTo(productB.type ?? ''));
                          }
                        }),
                    // DataColumn(
                    //   label: Text("USER ID"),
                    // ),
                    DataColumn(
                        label: Text("NAME OF USER"),
                        onSort: (columnIndex, _) {
                          transactionController
                              .transferCurrentSortColumn.value = columnIndex;
                          if (transactionController.transferIsAscending ==
                              true) {
                            transactionController.transferIsAscending.value =
                                false;
                            // sort the product list in Ascending, order by Price
                            transactionController.transferDataList
                                .sort((productA, productB) {
                              return (productB.user?.legalName ?? '')
                                  .compareTo(productA.user?.legalName ?? '');
                            });
                            // productB['price'].compareTo(productA['price']));
                          } else {
                            transactionController.transferIsAscending.value =
                                true;
                            // // sort the product list in Descending, order by Price
                            transactionController.transferDataList.sort(
                                (productA, productB) =>
                                    (productA.user?.legalName ?? '').compareTo(
                                        productB.user?.legalName ?? ''));
                          }
                        }),
                    DataColumn(
                        label: Text("DATE"),
                        onSort: (columnIndex, _) {
                          transactionController
                              .transferCurrentSortColumn.value = columnIndex;
                          if (transactionController.transferIsAscending ==
                              true) {
                            transactionController.transferIsAscending.value =
                                false;
                            // sort the product list in Ascending, order by Price
                            transactionController.transferDataList
                                .sort((productA, productB) {
                              return (productB.created ?? '')
                                  .compareTo(productA.created ?? '');
                            });
                            // productB['price'].compareTo(productA['price']));
                          } else {
                            transactionController.transferIsAscending.value =
                                true;
                            // // sort the product list in Descending, order by Price
                            transactionController.transferDataList.sort(
                                (productA, productB) => (productA.created ?? '')
                                    .compareTo(productB.created ?? ''));
                          }
                        }),
                    DataColumn(
                        label: Text("AMOUNT"),
                        onSort: (columnIndex, _) {
                          transactionController
                              .transferCurrentSortColumn.value = columnIndex;
                          if (transactionController.transferIsAscending ==
                              true) {
                            transactionController.transferIsAscending.value =
                                false;
                            // sort the product list in Ascending, order by Price
                            transactionController.transferDataList
                                .sort((productA, productB) {
                              return ((double.tryParse(
                                          productB.amount ?? '0.0')) ??
                                      (int.parse(productB.amount ?? '0')))
                                  .compareTo((double.tryParse(
                                          productA.amount ?? '0.0')) ??
                                      (int.parse(productA.amount ?? '0')));
                            });
                            // productB['price'].compareTo(productA['price']));
                          } else {
                            transactionController.transferIsAscending.value =
                                true;
                            // // sort the product list in Descending, order by Price
                            transactionController.transferDataList.sort(
                                (productA, productB) => ((double.tryParse(
                                            productA.amount ?? '0.0')) ??
                                        (int.parse(productA.amount ?? '0')))
                                    .compareTo((double.tryParse(
                                            productB.amount ?? '0.0')) ??
                                        (int.parse(productB.amount ?? '0'))));
                          }
                        }),
                    DataColumn(
                        label: Text("STATUS"),
                        onSort: (columnIndex, _) {
                          transactionController
                              .transferCurrentSortColumn.value = columnIndex;
                          if (transactionController.transferIsAscending ==
                              true) {
                            transactionController.transferIsAscending.value =
                                false;
                            // sort the product list in Ascending, order by Price
                            transactionController.transferDataList
                                .sort((productA, productB) {
                              return (productB.status ?? '')
                                  .compareTo(productA.status ?? '');
                            });
                            // productB['price'].compareTo(productA['price']));
                          } else {
                            transactionController.transferIsAscending.value =
                                true;
                            // // sort the product list in Descending, order by Price
                            transactionController.transferDataList.sort(
                                (productA, productB) => (productA.status ?? '')
                                    .compareTo(productB.status ?? ''));
                          }
                        }),
                  ],
                  rows: getCurrentPageData(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      if (transactionController.currentPage.value > 0)
                        transactionController.currentPage.value--;
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
                      (transactionController.currentPage.value + 1).toString()),
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
                      (transactionController.transferDataList.length / 10)
                          .ceil()
                          .toString()),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      if (transactionController.currentPage.value <
                          (transactionController.transferDataList.length /
                                      transactionController.rowsPerPage.value)
                                  .ceil() -
                              1) transactionController.currentPage.value++;
                    },
                    child: SvgPicture.asset(Assets.svgsNextIcon)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(Transfers fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Text(fileInfo.type ?? ''),
      ),
      // DataCell(Text(fileInfo.userId)),
      DataCell(Text(
        fileInfo.user?.legalName ?? '',
        style: TextStyle(color: darkBlueColor),
      )),
      DataCell(Text((Utils.stringTimeStampToStringDate(fileInfo.created ?? ''))
          .toString())),
      DataCell(Text(
        fileInfo.amount.toString(),
        style: TextStyle(color: Colors.green),
      )),
      DataCell(Text(
        fileInfo.status ?? '',
        style: TextStyle(color: Colors.green),
      )),
    ],
  );
}
