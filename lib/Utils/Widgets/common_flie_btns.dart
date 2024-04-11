import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/assets.dart';

class CommonFilePickerBtn extends StatelessWidget {
  const CommonFilePickerBtn(this.onTapUpload, this.onTapView,
      {this.isEyeVisible = false});
  final Function onTapUpload;
  final Function onTapView;
  final bool isEyeVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            onTapUpload();
          },
          child: Container(
            height: 43,
            alignment: Alignment.center,
            width: 55,
            decoration: BoxDecoration(
                color: Color(0xFFD7D7D7),
                borderRadius: BorderRadius.circular(0)),
            child: RotatedBox(
              quarterTurns: 1,
              child: SvgPicture.asset(
                Assets.svgsLogout,
                color: Colors.black,
                height: 22,
                width: 22,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            onTapView();
          },
          child: Container(
            height: 43,
            alignment: Alignment.center,
            width: 55,
            decoration: BoxDecoration(
                color: Color(0xFFD7D7D7),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: SvgPicture.asset(
              Assets.svgsEyeIcon,
              color:
                  isEyeVisible ? Colors.black : Colors.black.withOpacity(0.55),
              height: 18,
              width: 18,
            ),
          ),
        ),
      ],
    );
  }
}
