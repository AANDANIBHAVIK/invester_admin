import 'package:admin/Utils/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'users_controller.dart';

class UsersMainScreen extends StatefulWidget {
  @override
  State<UsersMainScreen> createState() => _UsersMainScreenState();
}

class _UsersMainScreenState extends State<UsersMainScreen> {
  UsersController usersController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Obx(
        () => Column(
          children: [
            Header(
              title: 'Users',
            ),
            usersController
                .userScreenList[usersController.currentSelectedScreen.value]
          ],
        ),
      ),
    );
  }
}
