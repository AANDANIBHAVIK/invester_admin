import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../documents_controller.dart';
import 'documents_table_data.dart';

class DocumentTable extends StatelessWidget {
  DocumentTable({
    Key? key,
  }) : super(key: key);

  DocumentsController documentsController = Get.put(DocumentsController());

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
              sortAscending: documentsController.documentIsAscending.value,
              sortColumnIndex:
                  documentsController.documentCurrentSortColumn.value,
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
                    label: Text("File Names"),
                    onSort: (columnIndex, _) {
                      documentsController.documentCurrentSortColumn.value =
                          columnIndex;
                      if (documentsController.documentIsAscending == true) {
                        documentsController.documentIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        documentsController.documentDataList
                            .sort((productA, productB) {
                          return (productB.documents?.fileName ?? '')
                              .compareTo(productA.documents?.fileName ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        documentsController.documentIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        documentsController.documentDataList.sort((productA,
                                productB) =>
                            (productA.documents?.fileName ?? '')
                                .compareTo(productB.documents?.fileName ?? ''));
                      }
                    }),
                DataColumn(
                  label: Text("Actions"),
                ),
              ],
              rows: getDocumentCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
