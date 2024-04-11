import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/screens/PropertyPage/property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class PropertyMainScreen extends StatefulWidget {
  @override
  State<PropertyMainScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyMainScreen> {
  PropertyController propertyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Obx(
        () => Column(
          children: [
            Header(
              title: 'Properties',
            ),
            propertyController.propertyScreenList[
                propertyController.currentSelectedScreen.value]
          ],
        ),
      ),
    );
  }
}
