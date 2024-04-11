// import 'package:admin/responsive.dart';
// import 'package:admin/screens/CompanyPage/company_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../constants.dart';
// import 'offer_table_data.dart';
//
// class CompanyTable extends StatelessWidget {
//   CompanyTable({
//     Key? key,
//   }) : super(key: key);
//
//   CompanyController companyController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Obx(
//         () => SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: SizedBox(
//             width: !Responsive.isDesktop(context)
//                 ? Responsive.isTablet(context)
//                     ? 1100
//                     : 800
//                 : MediaQuery.of(context).size.width * .74,
//             child: DataTable(
//               columnSpacing: defaultPadding,
//               showBottomBorder: false,
//               sortAscending: companyController.companyIsAscending.value,
//               sortColumnIndex: companyController.companyCurrentSortColumn.value,
//               dataRowHeight: 60,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(10)),
//               // border: TableBorder.all(
//               //     color: Colors.grey, borderRadius: BorderRadius.circular(10)),
//               // minWidth: 600,
//               columns: [
//                 DataColumn(
//                   label: Text("No"),
//                 ),
//                 DataColumn(
//                     label: Text("Name"),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productB.name ?? '')
//                               .compareTo(productA.name ?? '');
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList.sort(
//                             (productA, productB) => (productA.name ?? '')
//                                 .compareTo(productB.name ?? ''));
//                       }
//                     }),
//                 DataColumn(
//                     label: Text("Owner"),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productB.owner ?? '')
//                               .compareTo(productA.owner ?? '');
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList.sort(
//                             (productA, productB) => (productA.owner ?? '')
//                                 .compareTo(productB.owner ?? ''));
//                       }
//                     }),
//                 DataColumn(
//                     label: Text("Type"),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productB.type ?? '')
//                               .compareTo((productA.type ?? ''));
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productA.type ?? '')
//                               .compareTo((productB.type ?? ''));
//                         });
//                       }
//                     }),
//                 DataColumn(
//                     label: Expanded(
//                       child: Text(
//                         "Founded Year",
//                       ),
//                     ),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productB.foundedYear ?? '')
//                               .compareTo((productA.foundedYear ?? ''));
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productA.foundedYear ?? '')
//                               .compareTo((productB.foundedYear ?? ''));
//                         });
//                       }
//                     }),
//                 DataColumn(
//                     label: Text("Size Of the Company"),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productB.sizeOfCompany ?? '')
//                               .compareTo(productA.sizeOfCompany ?? '');
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList.sort(
//                             (productA, productB) =>
//                                 (productA.sizeOfCompany ?? '')
//                                     .compareTo(productB.sizeOfCompany ?? ''));
//                       }
//                     }),
//                 DataColumn(
//                     label: Text("Location"),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return (productB.location ?? '')
//                               .compareTo(productA.location ?? '');
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList.sort(
//                             (productA, productB) => (productA.location ?? '')
//                                 .compareTo(productB.location ?? ''));
//                       }
//                     }),
//                 DataColumn(
//                     label: Text("Number of Employees"),
//                     onSort: (columnIndex, _) {
//                       companyController.companyCurrentSortColumn.value =
//                           columnIndex;
//                       if (companyController.companyIsAscending == true) {
//                         companyController.companyIsAscending.value = false;
//                         // sort the product list in Ascending, order by Price
//                         companyController.companyDataList
//                             .sort((productA, productB) {
//                           return ((double.tryParse(productB.numOfEmp ?? '')) ??
//                                   (int.parse(productB.numOfEmp ?? '')))
//                               .compareTo(
//                                   (double.tryParse(productA.numOfEmp ?? '')) ??
//                                       (int.parse(productA.numOfEmp ?? '')));
//                         });
//                         // productB['price'].compareTo(productA['price']));
//                       } else {
//                         companyController.companyIsAscending.value = true;
//                         // // sort the product list in Descending, order by Price
//                         companyController.companyDataList.sort(
//                             (productA, productB) =>
//                                 ((double.tryParse(productA.numOfEmp ?? '')) ??
//                                         (int.parse(productA.numOfEmp ?? '')))
//                                     .compareTo((double.tryParse(
//                                             productB.numOfEmp ?? '')) ??
//                                         (int.parse(productB.numOfEmp ?? ''))));
//                       }
//                     }),
//                 DataColumn(
//                   label: Text("Actions"),
//                 ),
//               ],
//               rows: getCompanyCurrentPageData(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
