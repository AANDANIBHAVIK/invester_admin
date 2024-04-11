import 'package:admin/responsive.dart';
import 'package:admin/screens/FaQ/components/faq_table_data.dart';
import 'package:admin/screens/FaQ/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class FaqTable extends StatelessWidget {
  FaqTable({
    Key? key,
  }) : super(key: key);

  FaqController faqController = Get.put(FaqController());

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
              sortAscending: faqController.faqIsAscending.value,
              sortColumnIndex: faqController.faqCurrentSortColumn.value,
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
                      faqController.faqCurrentSortColumn.value = columnIndex;
                      if (faqController.faqIsAscending == true) {
                        faqController.faqIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        faqController.faqDataList.sort((productA, productB) {
                          return (productB.questions?.question ?? '')
                              .compareTo(productA.questions?.question ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        faqController.faqIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        faqController.faqDataList.sort((productA, productB) =>
                            (productA.questions?.question ?? '')
                                .compareTo(productB.questions?.question ?? ''));
                      }
                    }),
                DataColumn(
                    label: Text("Answers"),
                    onSort: (columnIndex, _) {
                      faqController.faqCurrentSortColumn.value = columnIndex;
                      if (faqController.faqIsAscending == true) {
                        faqController.faqIsAscending.value = false;
                        // sort the product list in Ascending, order by Price
                        faqController.faqDataList.sort((productA, productB) {
                          return (productB.questions?.answer ?? '')
                              .compareTo(productA.questions?.answer ?? '');
                        });
                        // productB['price'].compareTo(productA['price']));
                      } else {
                        faqController.faqIsAscending.value = true;
                        // // sort the product list in Descending, order by Price
                        faqController.faqDataList.sort((productA, productB) =>
                            (productA.questions?.answer ?? '')
                                .compareTo(productB.questions?.answer ?? ''));
                      }
                    }),
                DataColumn(
                  label: Text("Actions"),
                ),
              ],
              rows: getFaqCurrentPageData(),
            ),
          ),
        ),
      ),
    );
  }
}
