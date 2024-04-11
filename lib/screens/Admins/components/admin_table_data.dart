import 'package:admin/Data/Models/admin_model.dart';
import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/Admins/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'dialogBox.dart';

List<DataRow> getAdminCurrentPageData() {
  AdminController adminController = Get.put(AdminController());

  DataRow adminDataRow(AdminModel adminInfo, int index) {
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
            adminInfo.username ?? '-',
            color: Colors.black,
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    addAdminBox(Get.context!, adminController,
                        username: adminInfo.username,
                        password: adminInfo.password,
                        selectedID: adminInfo.aid);
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () {
                      adminController.deleteAdminData(adminInfo.aid);
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

  adminController.adminDataRowList.clear();
  int startIndex = adminController.adminCurrentPage.value *
      adminController.adminRowsPerPage.value;
  int endIndex = (startIndex + adminController.adminRowsPerPage.value)
      .clamp(0, adminController.adminDataList.length);
  // print(endIndex);
  List<AdminModel> _list =
      adminController.adminDataList.sublist(startIndex, endIndex);
  int index = 0;
  for (var i in _list) {
    index++;
    DataRow test = adminDataRow(i, index);
    adminController.adminDataRowList.add(test);
  }
  return adminController.adminDataRowList;
}
