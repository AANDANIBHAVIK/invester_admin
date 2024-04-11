import 'package:admin/Utils/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'enterprise_controller.dart';

class EnterpriseMainScreen extends StatefulWidget {
  @override
  State<EnterpriseMainScreen> createState() => _EnterpriseMainScreenState();
}

class _EnterpriseMainScreenState extends State<EnterpriseMainScreen> {
  EnterpriseController enterpriseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Obx(
        () => Column(
          children: [
            Header(
              title: 'EnterPrise User',
            ),
            enterpriseController.enterpriseScreenList[
                enterpriseController.currentSelectedScreen.value]
          ],
        ),
      ),
    );
  }
}
