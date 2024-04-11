import 'package:admin/Data/Models/user_model.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../users_controller.dart';
import 'user_table_data.dart';

class UserTable extends StatelessWidget {
  UserTable({
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
                : MediaQuery.of(context).size.width * .74,
            child: DataTable(
              columnSpacing: defaultPadding,
              showBottomBorder: false,
              sortAscending: usersController.isAscending.value,
              sortColumnIndex: usersController.currentSortColumn.value,
              dataRowHeight: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // border: TableBorder.all(
              //     color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Expanded(child: Text("Profile")),
                  // Sorting function
                  // onSort: (columnIndex, _) {
                  //   usersController.currentSortColumn.value = columnIndex;
                  //   if (usersController.isAscending == true) {
                  //     usersController.isAscending.value = false;
                  //     // sort the product list in Ascending, order by Price
                  //     usersController.userDataList.sort((productA, productB) {
                  //       return productB.fName!.compareTo(productA.fName!);
                  //     });
                  //     // productB['price'].compareTo(productA['price']));
                  //   } else {
                  //     usersController.isAscending.value = true;
                  //     // // sort the product list in Descending, order by Price
                  //     usersController.userDataList.sort(
                  //         (productA, productB) =>
                  //             productA.fName!.compareTo(productB.fName!));
                  //   }
                  // }
                ),
                DataColumn(
                    label: Expanded(child: Text("Contacts")),
                    onSort: (columnIndex, _) {
                      usersController.currentSortColumn.value = columnIndex;
                      if (usersController.isAscending == true) {
                        usersController.isAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.userDataList.sort((productA, productB) {
                          return productB.email!.compareTo(productA.email!);
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.isAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.userDataList.sort(
                            (productA, productB) =>
                                productA.email!.compareTo(productB.email!));
                      }
                    }),
                DataColumn(
                    label: Expanded(child: Text("Sign In With")),
                    onSort: (columnIndex, _) {
                      usersController.currentSortColumn.value = columnIndex;
                      if (usersController.isAscending == true) {
                        usersController.isAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.userDataList.sort((productA, productB) {
                          return (productB.signInWith ?? '')
                              .compareTo(productA.signInWith ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.isAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.userDataList.sort(
                            (productA, productB) => (productA.signInWith ?? '')
                                .compareTo(productB.signInWith ?? ''));
                      }
                    }),
                DataColumn(
                    label: Expanded(child: Text("Invested Projects")),
                    onSort: (columnIndex, _) {
                      usersController.currentSortColumn.value = columnIndex;
                      if (usersController.isAscending == true) {
                        usersController.isAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.userDataList.sort((productA, productB) {
                          return (productB.propertyInfo?.length ?? 0)
                              .compareTo(productA.propertyInfo?.length ?? 0);
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.isAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.userDataList.sort((productA,
                                productB) =>
                            (productA.propertyInfo?.length ?? 0)
                                .compareTo(productB.propertyInfo?.length ?? 0));
                      }
                    }),
                DataColumn(
                    label: Expanded(child: Text("Invested Amount")),
                    onSort: (columnIndex, _) {
                      usersController.currentSortColumn.value = columnIndex;

                      if (usersController.isAscending == true) {
                        usersController.isAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        usersController.userDataList.sort((productA, productB) {
                          double totalInvestProductA = 0.0;
                          double totalInvestProductB = 0.0;
                          for (PropertyInfo i in productA.propertyInfo ?? []) {
                            totalInvestProductA = totalInvestProductA +
                                ((double.tryParse(i.invested ?? '0.0')) ??
                                    (int.parse(i.invested ?? '0')));
                          }
                          for (var i in productB.propertyInfo ?? []) {
                            totalInvestProductB = totalInvestProductB +
                                ((double.tryParse(i.invested ?? '0.0')) ??
                                    (int.parse(i.invested ?? '0')));
                          }

                          return totalInvestProductB
                              .compareTo(totalInvestProductA);
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        usersController.isAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        usersController.userDataList.sort((productA, productB) {
                          double totalInvestProductA = 0.0;
                          double totalInvestProductB = 0.0;
                          for (PropertyInfo i in productA.propertyInfo ?? []) {
                            totalInvestProductA = totalInvestProductA +
                                ((double.tryParse(i.invested ?? '0.0')) ??
                                    (int.parse(i.invested ?? '0')));
                          }
                          for (var i in productB.propertyInfo ?? []) {
                            totalInvestProductB = totalInvestProductB +
                                ((double.tryParse(i.invested ?? '0.0')) ??
                                    (int.parse(i.invested ?? '0')));
                          }

                          return totalInvestProductA
                              .compareTo(totalInvestProductB);
                        });
                      }
                    }),
                DataColumn(
                  label: Expanded(child: Text("Action")),
                ),
              ],
              rows: getCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
