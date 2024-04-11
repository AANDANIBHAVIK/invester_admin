import 'package:admin/Data/Models/document_model.dart';
import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/Utils/Widgets/pdf_view_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../documents_controller.dart';
import 'dialogBox.dart';

List<DataRow> getDocumentCurrentPageData() {
  DocumentsController documentsController = Get.put(DocumentsController());

  DataRow documentDataRow(DocumentsModel documentInfo, int index) {
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
            documentInfo.documents?.fileName ?? '-',
            color: Colors.black,
          ),
        ),
        // DataCell(
        //   TextWidget(
        //     documentInfo.questions?.answer ?? '-',
        //     color: Colors.black,
        //     textAlign: TextAlign.start,
        //   ),
        // ),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    commonPdfViewDialog(
                      Get.context!,
                      pdfUrl: documentInfo.documents?.fileUrl,
                    );
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEyeIcon,
                    color: Colors.blueAccent,
                  )),
              IconButton(
                  onPressed: () {
                    addDocumentBox(Get.context!, documentsController,
                        name: documentInfo.documents?.fileName,
                        url: documentInfo.documents?.fileUrl,
                        selectedID: documentInfo.did);
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () {
                      documentsController.deleteDocumentData(documentInfo.did,
                          documentInfo.documents?.fileUrl ?? '');
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

  documentsController.documentDataRowList.clear();
  int startIndex = documentsController.documentCurrentPage.value *
      documentsController.documentRowsPerPage.value;
  int endIndex = (startIndex + documentsController.documentRowsPerPage.value)
      .clamp(0, documentsController.documentDataList.length);
  // print(endIndex);
  List<DocumentsModel> _list =
      documentsController.documentDataList.sublist(startIndex, endIndex);
  int index = 0;
  for (var i in _list) {
    index++;
    DataRow test = documentDataRow(i, index);
    documentsController.documentDataRowList.add(test);
  }
  return documentsController.documentDataRowList;
}
