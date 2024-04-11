import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../documents_controller.dart';

void addDocumentBox(
  BuildContext context,
  DocumentsController controller, {
  String? name,
  String? url,
  // Uint8List? memory,
  String? selectedID,
}) {
  controller.documentNameController.text = name ?? '';
  controller.documentUrlController.text = url ?? '';
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
            height: 300,
            width: 500,
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
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  selectedID == null ? 'Add Document' : 'Edit Document',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomFormTextField(
                  label: 'File Name',
                  controller: controller.documentNameController,
                  isFile: true,
                  enabled: false,
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      controller.getDocumentsStorage();
                    },
                    child: Container(
                      height: 43,
                      alignment: Alignment.center,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Color(0xFFDADADA),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextWidget(
                        'Choose File',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      buttonText: 'Back',
                      onBtnPress: () {
                        Get.back();
                      },
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                    CustomButton(
                      buttonText: 'Save',
                      onBtnPress: () {
                        controller.addDocumentData(
                            selectedDocument: selectedID);
                        Get.back();
                      },
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      );
    },
  );
}
