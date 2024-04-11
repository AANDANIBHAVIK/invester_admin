// import 'package:admin/Utils/Widgets/header.dart';
// import 'package:admin/screens/CompanyPage/company_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../constants.dart';
//
// class CompanyMainScreen extends StatefulWidget {
//   @override
//   State<CompanyMainScreen> createState() => _CompanyScreenState();
// }
//
// class _CompanyScreenState extends State<CompanyMainScreen> {
//   CompanyController companyController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       primary: false,
//       padding: EdgeInsets.all(defaultPadding),
//       child: Obx(
//         () => Column(
//           children: [
//             Header(
//               title: 'Companies',
//             ),
//             companyController.companyScreenList[
//                 companyController.currentSelectedScreen.value]
//           ],
//         ),
//       ),
//     );
//   }
// }
