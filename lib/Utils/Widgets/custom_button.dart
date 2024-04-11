import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.borderRadius = 10,
      required this.buttonText,
      this.height = 8.0,
      this.width = 100.0,
      this.backgroundColor = darkBlueColor,
      this.textColor = Colors.white,
      this.fontSize,
      required this.onBtnPress,
      this.borderColor,
      this.fontWeight = FontWeight.w600,
      this.widget})
      : super(key: key);
  final double borderRadius;
  final String buttonText;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double? fontSize;
  final Function onBtnPress;
  final FontWeight fontWeight;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          onBtnPress();
          // print("object");
        },
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: (height * 850) / 100,
          width: (width * 1485) / 110,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(20, 64, 113, 134),
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
              color: backgroundColor,
              border:
                  Border.all(width: 2, color: borderColor ?? backgroundColor),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Center(
              child: widget ??
                  TextWidget(
                    buttonText,
                    color: textColor,
                    fontSize: fontSize ?? 17,
                    fontWeight: fontWeight,
                  )),
        ),
      ),
    );
  }
}

// class CustomTextButton extends StatelessWidget {
//   const CustomTextButton(
//       {Key? key,
//       required this.buttonText,
//       this.textColor = AppColor.blueColor,
//       this.fontSize,
//       required this.onBtnPress,
//       this.fontWeight = FontWeight.w700,
//       this.widget})
//       : super(key: key);
//   final String buttonText;
//   final Color textColor;
//   final double? fontSize;
//   final Function onBtnPress;
//   final FontWeight fontWeight;
//   final Widget? widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onBtnPress();
//         // print("object");
//       },
//       child: Center(
//           child: widget ??
//               TextWidget(
//                 buttonText,
//                 color: textColor,
//                 fontSize: fontSize ?? 15.sp,
//                 fontWeight: fontWeight,
//               )),
//     );
//   }
// }
