import 'package:admin/responsive.dart';
import 'package:admin/screens/PropertyPage/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'property_table_data.dart';

class PropertyTable extends StatelessWidget {
  PropertyTable({
    Key? key,
  }) : super(key: key);

  PropertyController propertyController = Get.put(PropertyController());

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
              sortAscending: propertyController.propertyIsAscending.value,
              sortColumnIndex:
                  propertyController.propertyCurrentSortColumn.value,
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
                  label: Text("Image"),
                ),
                DataColumn(
                    label: Text("Address"),
                    onSort: (columnIndex, _) {
                      propertyController.propertyCurrentSortColumn.value =
                          columnIndex;
                      if (propertyController.propertyIsAscending == true) {
                        propertyController.propertyIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        propertyController.propertyDataList
                            .sort((productA, productB) {
                          return (productB.address?.street ?? '')
                              .compareTo(productA.address?.street ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        propertyController.propertyIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        propertyController.propertyDataList.sort(
                            (productA, productB) =>
                                (productA.address?.street ?? '')
                                    .compareTo(productB.address?.street ?? ''));
                      }
                    }),
                // DataColumn(
                //     label: Text("Sold"),
                //     onSort: (columnIndex, _) {
                //       propertyController.propertyCurrentSortColumn.value =
                //           columnIndex;
                //       if (propertyController.propertyIsAscending == true) {
                //         propertyController.propertyIsAscending.value = false;
                //         // sort the product list in Ascending, order by Price
                //         propertyController.propertyDataList
                //             .sort((productA, productB) {
                //           return ((double.tryParse(productB.sold ?? '0.0')) ??
                //                   (int.parse(productB.sold ?? '0')))
                //               .compareTo(
                //                   (double.tryParse(productA.sold ?? '0.0')) ??
                //                       (int.parse(productA.sold ?? '0')));
                //         });
                //         // productB['price'].compareTo(productA['price']));
                //       } else {
                //         propertyController.propertyIsAscending.value = true;
                //         // // sort the product list in Descending, order by Price
                //         propertyController.propertyDataList
                //             .sort((productA, productB) {
                //           return ((double.tryParse(productA.sold ?? '0.0')) ??
                //                   (int.parse(productA.sold ?? '0')))
                //               .compareTo(
                //                   (double.tryParse(productB.sold ?? '0.0')) ??
                //                       (int.parse(productB.sold ?? '0')));
                //         });
                //       }
                //     }),
                DataColumn(
                    label: Expanded(
                      child: Text(
                        "Investment amount",
                      ),
                    ),
                    onSort: (columnIndex, _) {
                      propertyController.propertyCurrentSortColumn.value =
                          columnIndex;
                      if (propertyController.propertyIsAscending == true) {
                        propertyController.propertyIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        propertyController.propertyDataList
                            .sort((productA, productB) {
                          return ((double.tryParse(
                                      productB.investmentPrice ?? '0.0')) ??
                                  (int.parse(productB.investmentPrice ?? '0')))
                              .compareTo((double.tryParse(
                                      productA.investmentPrice ?? '0.0')) ??
                                  (int.parse(productA.investmentPrice ?? '0')));
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        propertyController.propertyIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        propertyController.propertyDataList
                            .sort((productA, productB) {
                          return ((double.tryParse(
                                      productA.investmentPrice ?? '0.0')) ??
                                  (int.parse(productA.investmentPrice ?? '0')))
                              .compareTo((double.tryParse(
                                      productB.investmentPrice ?? '0.0')) ??
                                  (int.parse(productB.investmentPrice ?? '0')));
                        });
                      }
                    }),
                DataColumn(
                    label: Text("Category"),
                    onSort: (columnIndex, _) {
                      propertyController.propertyCurrentSortColumn.value =
                          columnIndex;
                      if (propertyController.propertyIsAscending == true) {
                        propertyController.propertyIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        propertyController.propertyDataList
                            .sort((productA, productB) {
                          return (productB.category ?? '')
                              .compareTo(productA.category ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        propertyController.propertyIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        propertyController.propertyDataList.sort(
                            (productA, productB) => (productA.category ?? '')
                                .compareTo(productB.category ?? ''));
                      }
                    }),
                DataColumn(
                    label: Text("Offer Timing"),
                    onSort: (columnIndex, _) {
                      propertyController.propertyCurrentSortColumn.value =
                          columnIndex;
                      if (propertyController.propertyIsAscending == true) {
                        propertyController.propertyIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        propertyController.propertyDataList
                            .sort((productA, productB) {
                          return (productB.offer ?? '')
                              .compareTo(productA.offer ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        propertyController.propertyIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        propertyController.propertyDataList.sort(
                            (productA, productB) => (productA.offer ?? '')
                                .compareTo(productB.offer ?? ''));
                      }
                    }),
                DataColumn(
                    label: Text("Offer Type"),
                    onSort: (columnIndex, _) {
                      propertyController.propertyCurrentSortColumn.value =
                          columnIndex;
                      if (propertyController.propertyIsAscending == true) {
                        propertyController.propertyIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        propertyController.propertyDataList
                            .sort((productA, productB) {
                          return (productB.status ?? '')
                              .compareTo(productA.status ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        propertyController.propertyIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        propertyController.propertyDataList.sort(
                            (productA, productB) => (productA.status ?? '')
                                .compareTo(productB.status ?? ''));
                      }
                    }),
                DataColumn(
                  label: Text("Actions"),
                ),
              ],
              rows: getPropertyCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
