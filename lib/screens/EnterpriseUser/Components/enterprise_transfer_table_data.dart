import 'package:admin/Data/Models/user_model.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enterprise_controller.dart';

List<DataRow> getTransferCurrentPageData() {
  EnterpriseController enterpriseController = Get.find();

  DataRow transactionDataRow(Transactions transactions, int index) {
    return DataRow(
      cells: [
        DataCell(Text(index.toString())),
        DataCell(
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              transactions.propertyImg ?? '',
              height: 38,
              width: 70,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(placeHolderImg,
                    height: 38, width: 70, fit: BoxFit.cover);
              },
            ),
          ),
        ),
        DataCell(Text(
          transactions.propertyName ?? '',
          style: TextStyle(color: darkBlueColor),
        )),
        DataCell(Text(transactions.date ?? '')),
        DataCell(Text(
          '\$${transactions.amount ?? ''}',
          style: TextStyle(color: Colors.green),
        )),
      ],
    );
  }

  enterpriseController.transactionDataRowList.clear();
  int startIndex = enterpriseController.transactionCurrentPage.value *
      enterpriseController.transactionRowsPerPage.value;
  int endIndex =
      (startIndex + enterpriseController.transactionRowsPerPage.value)
          .clamp(0, enterpriseController.transactionDataList.length);
  // print(endIndex);
  List<Transactions> _list =
      enterpriseController.transactionDataList.sublist(startIndex, endIndex);
  int _index = 0;
  for (var i in _list) {
    _index++;
    DataRow test = transactionDataRow(i, _index);
    enterpriseController.transactionDataRowList.add(test);
  }
  return enterpriseController.transactionDataRowList;
}
