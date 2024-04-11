import 'dart:typed_data';

import 'package:admin/Utils/Widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void commonPdfViewDialog(BuildContext context,
    {String? pdfUrl, Uint8List? memoryPdf}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xA2573EF),
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: 2),
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: memoryPdf != null
                  ? SfPdfViewer.memory(memoryPdf,
                      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails) {
                      SnackBars.errorSnackBar(
                          content: 'Document Load Failed...');
                    })
                  : SfPdfViewer.network(pdfUrl!,
                      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails) {
                      SnackBars.errorSnackBar(
                          content: 'Document Load Failed...');
                    }),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                  onTap: () async {
                    Get.back();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey,
                        size: 25,
                      ))),
            ),
          ],
        ),
      );
    },
  );
}
