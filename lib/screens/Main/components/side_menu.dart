import 'package:admin/Routes/routes.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () => ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.iconsAppIcon),
                  SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    'Investtor',
                    fontWeight: FontWeight.w600,
                    color: darkBlueColor,
                    fontSize: 24,
                  )
                ],
              ),
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[0],
              svgSrc: Assets.svgsUserSquare,
              press: () {
                mainController.selectedWidget.value = 0;
              },
              isSelected: mainController.selectedWidget.value == 0,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[1],
              svgSrc: Assets.svgsProfile2user,
              press: () {
                mainController.selectedWidget.value = 1;
              },
              isSelected: mainController.selectedWidget.value == 1,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[2],
              svgSrc: Assets.svgsBuilding,
              press: () {
                mainController.selectedWidget.value = 2;
              },
              isSelected: mainController.selectedWidget.value == 2,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[3],
              svgSrc: Assets.svgsHouse2,
              press: () {
                mainController.selectedWidget.value = 3;
              },
              isSelected: mainController.selectedWidget.value == 3,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[4],
              svgSrc: Assets.svgsReceiptEdit,
              press: () {
                mainController.selectedWidget.value = 4;
              },
              isSelected: mainController.selectedWidget.value == 4,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[5],
              svgSrc: Assets.svgsCardEdit,
              press: () {
                mainController.selectedWidget.value = 5;
              },
              isSelected: mainController.selectedWidget.value == 5,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[6],
              svgSrc: Assets.svgsEdit,
              press: () {
                mainController.selectedWidget.value = 6;
              },
              isSelected: mainController.selectedWidget.value == 6,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[7],
              svgSrc: Assets.svgsNote2,
              press: () {
                mainController.selectedWidget.value = 7;
              },
              isSelected: mainController.selectedWidget.value == 7,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[8],
              svgSrc: Assets.svgsSetting,
              press: () {
                mainController.selectedWidget.value = 8;
              },
              isSelected: mainController.selectedWidget.value == 8,
            ),
            DrawerListTile(
              title: mainController.SidebarNameList[9],
              svgSrc: Assets.svgsLogout,
              press: () async {
                await GetStorage().remove('loginEmail');
                Get.offAllNamed(Routes.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void getBack(BuildContext context) {
  if (!Responsive.isDesktop(context)) {
    Get.back();
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    this.isSelected = false,
  }) : super(key: key);

  final String title, svgSrc;
  final Function press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getBack(context);
        press();
      },
      child: Stack(
        children: [
          Container(
            height: 65,
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: isSelected ? textFieldBgColor : Colors.transparent),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(
                    svgSrc,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.srcIn),
                    height: 16,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: textColor, fontSize: 16),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 65,
            width: 18,
            margin: EdgeInsets.only(left: 15),
            padding: EdgeInsets.only(left: 35),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: isSelected ? darkBlueColor : Colors.transparent),
          ),
        ],
      ),
    );
  }
}
