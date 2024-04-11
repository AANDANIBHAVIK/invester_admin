import 'package:admin/Data/Models/faq_model.dart';
import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/FaQ/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'dialogBox.dart';

List<DataRow> getFaqCurrentPageData() {
  FaqController faqController = Get.put(FaqController());

  DataRow faqDataRow(FaqModel faqInfo, int index) {
    return DataRow(
      cells: [
        DataCell(
          TextWidget(
            '$index',
            color: Colors.black,
          ),
        ),
        DataCell(
          TextWidget(
            faqInfo.questions?.question ?? '-',
            color: Colors.black,
          ),
        ),
        DataCell(
          TextWidget(
            faqInfo.questions?.answer ?? '-',
            color: Colors.black,
            textAlign: TextAlign.start,
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    addFaqBox(Get.context!, faqController,
                        question: faqInfo.questions?.question,
                        answer: faqInfo.questions?.answer,
                        selectedID: faqInfo.qid);
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () {
                      faqController.deleteFaqData(faqInfo.qid);
                    });
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsDeleteIcon,
                    color: Colors.redAccent,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  faqController.faqDataRowList.clear();
  int startIndex =
      faqController.faqCurrentPage.value * faqController.faqRowsPerPage.value;
  int endIndex = (startIndex + faqController.faqRowsPerPage.value)
      .clamp(0, faqController.faqDataList.length);
  // print(endIndex);
  List<FaqModel> _list =
      faqController.faqDataList.sublist(startIndex, endIndex);
  int index = 0;
  for (var i in _list) {
    index++;
    DataRow test = faqDataRow(i, index);
    faqController.faqDataRowList.add(test);
  }
  return faqController.faqDataRowList;
}
