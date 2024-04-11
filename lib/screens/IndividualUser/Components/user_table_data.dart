import 'package:admin/Data/Models/user_model.dart';
import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../users_controller.dart';

List<DataRow> getCurrentPageData() {
  UsersController usersController = Get.find();

  DataRow usersDataRow(UserModel userInfo) {
    double totalInvest = 0.0;
    for (PropertyInfo i in userInfo.propertyInfo ?? []) {
      totalInvest = totalInvest +
          ((double.tryParse(i.invested ?? '0.0')) ??
              (int.parse(i.invested ?? '0')));
    }
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  (userInfo.profileImg ?? ''),
                  height: 38,
                  width: 38,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(placeHolderImg,
                        height: 38, width: 38, fit: BoxFit.cover);
                  },
                ),
              ),
              // SizedBox(
              //   width: 5,
              // ),
              // TextWidget(
              //   userInfo.fName ?? '',
              //   color: Colors.black,
              // ),
            ],
          ),
        ),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userInfo.email ?? '',
              style: TextStyle(color: darkBlueColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              userInfo.phone ?? '',
              style: TextStyle(
                  color: darkBlueColor.withOpacity(0.8), fontSize: 13),
            ),
          ],
        )),
        DataCell(Text((userInfo.signInWith ?? '').toString())),
        DataCell(Text((userInfo.propertyInfo?.length ?? 0).toString())),
        DataCell(Text(
          '\$${totalInvest}',
          style: TextStyle(color: Colors.green),
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    usersController.currentSelectedScreen.value = 1;
                    usersController.selectedUserId.value = userInfo.uid ?? '';
                    if (usersController.selectedUserId.value != '') {
                      usersController.getSelectedUserData();
                    }
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () {
                      usersController.deleteUsers(
                        userInfo.uid ?? '',
                        userInfo.profileImg ?? '',
                        userInfo.accountInfo?.accountType?.individual?.document
                                ?.drivingLicenseUrl ??
                            '',
                        userInfo.accountInfo?.accountType?.individual?.document
                                ?.socialSecurityUrl ??
                            '',
                      );
                    });
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsDeleteIcon,
                    color: Colors.redAccent,
                  )),
              // CustomButton(
              //   buttonText: 'Edit',
              //   onBtnPress: () {
              //     usersController.currentSelectedScreen.value = 1;
              //     usersController.selectedUserId.value = userInfo.uid ?? '';
              //     if (usersController.selectedUserId.value != '') {
              //       usersController.getSelectedUserData();
              //     }
              //   },
              //   width: 5,
              //   height: 4,
              //   borderRadius: 5,
              //   fontSize: 15,
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              // CustomButton(
              //   buttonText: 'Delete',
              //   onBtnPress: () {
              //     DeleteConfirmBox(Get.context!, () {
              //       usersController.deleteUsers(
              //           userInfo.uid ?? '',
              //           userInfo.profileImg ?? '',
              //           userInfo.accountInfo?.accountType?.individual?.document
              //                   ?.documentUrl ??
              //               '');
              //     });
              //   },
              //   width: 5,
              //   height: 4,
              //   fontSize: 15,
              //   borderRadius: 5,
              //   backgroundColor: Colors.redAccent,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  usersController.dataRowList.clear();
  int startIndex =
      usersController.currentPage.value * usersController.rowsPerPage.value;
  int endIndex = (startIndex + usersController.rowsPerPage.value)
      .clamp(0, usersController.userDataList.length);
  // print(endIndex);
  List<UserModel> _list =
      usersController.userDataList.sublist(startIndex, endIndex);
  for (var i in _list) {
    DataRow test = usersDataRow(i);
    usersController.dataRowList.add(test);
  }
  return usersController.dataRowList;
}
