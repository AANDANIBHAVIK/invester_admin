import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/CompanyPage/company_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CompanyDetailsScreen extends StatefulWidget {
  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  CompanyController companyController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // companyController.currentSelectedScreen.value = 0;
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // print("${width} + ${height}");
    return Obx(
      () => companyController.isLoading.value
          ? Container()
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xA2573EF),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 2),
                ],
              ),
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        "Company Details",
                        fontSize: 20,
                      ),
                      Spacer(),
                      CustomButton(
                        buttonText: 'Save',
                        onBtnPress: () async {
                          await companyController.setSelectedCompanyData();
                          // companyController.currentSelectedScreen.value = 0;
                        },
                        width: 10,
                        height: 4,
                        fontSize: 15,
                        borderRadius: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                        buttonText: 'Back',
                        onBtnPress: () {
                          companyController.onBack();
                        },
                        width: 10,
                        height: 4,
                        fontSize: 15,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 0,
                    childAspectRatio: width /
                        (defaultHeight /
                            (!Responsive.isDesktop(context)
                                ? Responsive.isMobile(context)
                                    ? 9.5
                                    : 4.5
                                : 2.5)),
                    crossAxisCount: Responsive.isMobile(context)
                        ? 1
                        : Responsive.isTablet(context)
                            ? 2
                            : 3,
                    crossAxisSpacing: 20,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      CustomFormTextField(
                        label: 'Company Name',
                        controller: companyController.nameController,
                      ),
                      CustomFormTextField(
                        label: 'Type',
                        controller: companyController.typeController,
                      ),
                      CustomFormTextField(
                        label: 'Owner',
                        controller: companyController.ownerController,
                      ),
                      CustomFormTextField(
                        label: 'Founded Year',
                        controller: companyController.foundedYearController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                      ),
                      CustomFormTextField(
                        label: 'Size of the Company',
                        controller: companyController.sizeCompanyController,
                      ),
                      CustomFormTextField(
                        label: 'Location',
                        controller: companyController.locationController,
                      ),
                      CustomFormTextField(
                        label: 'Website',
                        controller: companyController.websiteController,
                      ),
                      CustomFormTextField(
                        label: 'Number of Employees',
                        controller: companyController.numOfEmpController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
