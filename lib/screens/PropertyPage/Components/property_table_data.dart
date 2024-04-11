import 'package:admin/Data/Models/property_model.dart';
import 'package:admin/Utils/Widgets/delete_dialog.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/screens/PropertyPage/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

List<DataRow> getPropertyCurrentPageData() {
  PropertyController propertyController = Get.find();

  DataRow propertyDataRow(PropertyModel propertyInfo, int index) {
    return DataRow(
      cells: [
        DataCell(
          TextWidget(
            '$index',
            color: Colors.black,
          ),
        ),
        DataCell(
          SizedBox(
            width: 60,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                propertyInfo.image?.first ?? placeHolderImg,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(placeHolderImg, fit: BoxFit.cover);
                },
              ),
            ),
          ),
        ),
        DataCell(
          TextWidget(
            propertyInfo.address?.street ?? '-',
            color: Colors.black,
          ),
        ),
        // DataCell(Text(
        //   (propertyInfo.sold ?? 0).toString(),
        //   style: TextStyle(color: darkBlueColor),
        // )),
        DataCell(
          Text(
            (propertyInfo.investmentPrice ?? 0).toString(),
            style: TextStyle(color: darkBlueColor),
          ),
        ),
        DataCell(Text(
          propertyInfo.category ?? '-',
        )),
        DataCell(Text(
          propertyInfo.offer ?? '-',
          style: TextStyle(color: Colors.green),
        )),
        DataCell(Text(
          propertyInfo.status ?? '-',
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    propertyController.onPropertyDetails();
                    propertyController.selectedPropertyId.value =
                        propertyInfo.pId ?? '';
                    if (propertyController.selectedPropertyId.value != '') {
                      propertyController.getSelectedPropertyData();
                      // propertyController.getSelectedUserData();
                    }
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsEditIcon,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () async {
                    DeleteConfirmBox(Get.context!, () async {
                      await propertyController.deletePropertyData(
                          propertyInfo.pId ?? '',
                          propertyInfo!.image,
                          propertyInfo.video,
                          propertyInfo.documents!.fileUrl,
                          propertyInfo.propertyDetails!.fileUrl,
                          propertyInfo.cashFinancing!.fileUrl);
                    });
                  },
                  icon: SvgPicture.asset(
                    Assets.svgsDeleteIcon,
                    color: Colors.redAccent,
                  )),
              // CustomButton(
              //   buttonText: 'Edit',
              //   onBtnPress: () {
              //     propertyController.currentSelectedScreen.value = 1;
              //     propertyController.selectedPropertyId.value =
              //         propertyInfo.pId ?? '';
              //     if (propertyController.selectedPropertyId.value != '') {
              //       propertyController.getSelectedPropertyData();
              //       // propertyController.getSelectedUserData();
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

  propertyController.propertyDataRowList.clear();
  int startIndex = propertyController.propertyCurrentPage.value *
      propertyController.propertyRowsPerPage.value;
  int endIndex = (startIndex + propertyController.propertyRowsPerPage.value)
      .clamp(0, propertyController.propertyDataList.length);
  // print(endIndex);
  List<PropertyModel> _list =
      propertyController.propertyDataList.sublist(startIndex, endIndex);
  int index = 0;
  for (var i in _list) {
    index++;
    DataRow test = propertyDataRow(i, index);
    propertyController.propertyDataRowList.add(test);
  }
  return propertyController.propertyDataRowList;
}
