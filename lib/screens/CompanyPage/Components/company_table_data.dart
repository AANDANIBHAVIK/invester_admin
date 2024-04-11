import 'package:admin/Data/Models/companies_model.dart';
import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/CompanyPage/company_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

List<DataRow> getCompanyCurrentPageData() {
  CompanyController companyController = Get.find();

  DataRow companyDataRow(CompaniesModel companyInfo, int index) {
    return DataRow(
      cells: [
        DataCell(
          TextWidget(
            '$index',
            color: Colors.black,
          ),
        ),
        DataCell(
          Text(
            companyInfo.name ?? '',
            style: TextStyle(color: darkBlueColor),
          ),
        ),
        DataCell(
          TextWidget(
            companyInfo.owner ?? '-',
            color: Colors.black,
          ),
        ),
        DataCell(Text(
          (companyInfo.type ?? '').toString(),
          style: TextStyle(color: darkBlueColor),
        )),
        DataCell(
          Text(
            (companyInfo.foundedYear ?? 0).toString(),
            style: TextStyle(color: darkBlueColor),
          ),
        ),
        DataCell(Text(
          companyInfo.sizeOfCompany ?? '',
          style: TextStyle(color: Colors.green),
        )),
        DataCell(Text(
          companyInfo.location ?? '',
        )),
        DataCell(Text(
          companyInfo.numOfEmp ?? '-',
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    companyController.onCompanyDetails();
                    companyController.selectedCompanyId.value =
                        companyInfo.cid ?? '';
                    if (companyController.selectedCompanyId.value != '') {
                      companyController.getSelectedCompanyData();
                      // companyController.getSelectedUserData();
                    }
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () async {
                      await companyController
                          .deleteCompany(companyInfo.cid ?? '');
                    });
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsDeleteIcon,
                    color: Colors.redAccent,
                  )),
              // CustomButton(
              //   buttonText: 'Edit',
              //   onBtnPress: () {
              //     companyController.currentSelectedScreen.value = 1;
              //     companyController.selectedCompanyId.value =
              //         companyInfo.pId ?? '';
              //     if (companyController.selectedCompanyId.value != '') {
              //       companyController.getSelectedCompanyData();
              //       // companyController.getSelectedUserData();
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
              //   onBtnPress: () {},
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

  companyController.companyDataRowList.clear();
  int startIndex = companyController.companyCurrentPage.value *
      companyController.companyRowsPerPage.value;
  int endIndex = (startIndex + companyController.companyRowsPerPage.value)
      .clamp(0, companyController.companyDataList.length);
  // print(endIndex);
  List<CompaniesModel> _list =
      companyController.companyDataList.sublist(startIndex, endIndex);
  int index = 0;
  for (var i in _list) {
    index++;
    DataRow test = companyDataRow(i, index);
    companyController.companyDataRowList.add(test);
  }
  return companyController.companyDataRowList;
}
