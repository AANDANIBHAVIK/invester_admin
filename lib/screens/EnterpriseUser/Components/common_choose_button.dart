import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomMultiChooseButton extends StatelessWidget {
  const CustomMultiChooseButton(
      {Key? key,
      this.borderRadius = 10,
      required this.buttonText,
      this.height = 8.5,
      this.width = 100.0,
      this.backgroundColor = Colors.blueAccent,
      this.textColor = Colors.white,
      this.fontSize,
      required this.onBtnPress,
      this.onActionBtnPress,
      this.borderColor,
      this.fontWeight = FontWeight.w400,
      this.widget,
      this.margin,
      this.isSelected = false,
      this.isSuffixShow = false,
      this.selectedMethod2 = false})
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
  final Function? onActionBtnPress;
  final FontWeight fontWeight;
  final Widget? widget;
  final EdgeInsets? margin;
  final bool isSelected;
  final bool isSuffixShow;
  final bool selectedMethod2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onBtnPress();
        // print("object");
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: (height * MediaQuery.of(context).size.height) / 100,
            width: (width * MediaQuery.of(context).size.width) / 100,
            margin: margin ?? const EdgeInsets.symmetric(vertical: 7),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 1,
                    color: isSelected ? Colors.blueAccent : Colors.grey),
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: isSelected
                      ? Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.blueAccent,
                        )
                      : selectedMethod2
                          ? const SizedBox()
                          : Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                            ),
                ),
                Expanded(
                  child: widget ??
                      TextWidget(
                        buttonText,
                        color: isSelected ? Colors.blueAccent : Colors.grey,
                        fontSize: fontSize ?? 12,
                        fontWeight: fontWeight,
                        textAlign: TextAlign.start,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: isSuffixShow
                      ? GestureDetector(
                          onTap: () {
                            if (onActionBtnPress != null) {
                              onActionBtnPress!();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.ios_share_rounded,
                              color: Colors.blueAccent,
                              size: 22,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
