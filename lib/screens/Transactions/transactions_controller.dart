import 'package:admin/Data/Models/transfers_model.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'transaction_repository.dart';

class TransactionController extends GetxController {
  // RxInt currentPageIndex = 1.obs;

  RxInt transferCurrentPage = 0.obs;
  RxInt transferRowsPerPage = 10.obs;
  List<DataRow> transferDataRowList = [];
  RxList<Transfers> transferDataList = <Transfers>[].obs;
  RxInt transferCurrentSortColumn = 0.obs;
  RxBool transferIsAscending = true.obs;

  RxInt currentPage = 0.obs;
  RxInt rowsPerPage = 10.obs;

  TransferRepository transferRepository = TransferRepository();
  var isLoading = true.obs;

  @override
  onInit() {
    getTransfersData();
    super.onInit();
  }

  getTransfersData() async {
    TransferModel transferInfo = await transferRepository.getTransferInfo({
      "client_id": AppPreferencesHelper.CLIENT_ID,
      "secret_key": AppPreferencesHelper.SECRET_KEY,
    });

    List<Transfers> _tempList = [];
    transferDataList.clear();
    for (var i in transferInfo.transfers ?? []) {
      _tempList.add(i);
      // print(i);
    }
    transferDataList.addAll(_tempList);
    EasyLoading.dismiss();
  }
}
