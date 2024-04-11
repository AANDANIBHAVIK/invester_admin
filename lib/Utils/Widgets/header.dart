import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/generated/assets.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: textColor,
                ),
                onPressed: () {
                  mainController.controlMenu();
                },
              ),
            if (!Responsive.isMobile(context)) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "$title",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(width: 10),
              VerticalDivider(
                color: textColor.withOpacity(0.9),
                width: 1,
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              SizedBox(width: 10),
            ],
            // Expanded(child: SearchField()),
            if (!Responsive.isMobile(context))
              // Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              // GestureDetector(
              //   child: Stack(
              //     alignment: Alignment.topRight,
              //     children: [
              //       SvgPicture.asset(Assets.iconsNotificationBellIcon),
              //       Icon(
              //         Icons.circle_rounded,
              //         color: Colors.red,
              //         size: 10,
              //       )
              //     ],
              //   ),
              // ),
              ProfileCard()
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => TextWidget(
                      mainController.loginEmail.value.toString(),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(100),
          //   child: Image.asset(
          //     Assets.imagesProfilePic,
          //     height: 38,
          //   ),
          // ),
          // Icon(
          //   Icons.keyboard_arrow_down,
          //   color: textColor,
          // ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: textColor, fontWeight: FontWeight.w400),
        fillColor: secondaryColor,
        filled: false,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.1),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: SvgPicture.asset(
              Assets.iconsSearch,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
