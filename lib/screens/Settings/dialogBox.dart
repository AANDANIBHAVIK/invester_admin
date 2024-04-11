import 'package:admin/Utils/Widgets/custom_button.dart';
import 'package:admin/Utils/Widgets/custom_form_fields.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:admin/screens/Settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void addYoutubeLinkBox2(BuildContext context, SettingController controller,
    TextEditingController textEditingController) {
  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
            height: 250,
            width: 400,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xA2573EF),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 2),
                ],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  'Add Youtube Video Link',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomFormTextField(
                  label: 'Paste Link',
                  controller: textEditingController,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      buttonText: 'Back',
                      onBtnPress: () {
                        Get.back();
                      },
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                    CustomButton(
                      buttonText: 'Save',
                      onBtnPress: () {
                        controller
                            .uploadVideoFirebase(textEditingController.text);
                        Get.back();
                      },
                      width: 8,
                      height: 4,
                      fontSize: 15,
                      borderRadius: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      );
    },
  );
}

// void playYoutubeLinkBox2(BuildContext context, String videoLink) {
//   showDialog(
//     context: context,
//     useRootNavigator: true,
//     builder: (BuildContext context) {
//       PodPlayerController controller = PodPlayerController(
//         podPlayerConfig: PodPlayerConfig(
//           autoPlay: true,
//         ),
//         playVideoFrom: PlayVideoFrom.youtube(videoLink),
//       )..initialise();
//       return Align(
//         alignment: Alignment.center,
//         child: Container(
//           height: 400,
//           // padding: EdgeInsets.all(25),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                     color: Color(0xA2573EF),
//                     offset: Offset(2, 2),
//                     blurRadius: 5,
//                     spreadRadius: 2),
//               ],
//               borderRadius: BorderRadius.circular(20)),
//           child: AspectRatio(
//             aspectRatio: 16 / 9,
//             child: PodVideoPlayer(controller: controller),
//           ),
//         ),
//       );
//     },
//   );
// }
