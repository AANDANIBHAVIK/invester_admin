import 'package:admin/Data/Models/user_model.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../users_controller.dart';

List<DataRow> getTransferCurrentPageData() {
  UsersController usersController = Get.find();

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
              fit: BoxFit.cover,
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

  usersController.transactionDataRowList.clear();
  int startIndex = usersController.transactionCurrentPage.value *
      usersController.transactionRowsPerPage.value;
  int endIndex = (startIndex + usersController.transactionRowsPerPage.value)
      .clamp(0, usersController.transactionDataList.length);
  // print(endIndex);
  List<Transactions> _list =
      usersController.transactionDataList.sublist(startIndex, endIndex);
  int _index = 0;
  for (var i in _list) {
    _index++;
    DataRow test = transactionDataRow(i, _index);
    usersController.transactionDataRowList.add(test);
  }
  return usersController.transactionDataRowList;
}
