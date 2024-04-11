import 'package:flutter/material.dart';

Widget commonDivider({
  Color? bgColor,
  double? thikness,
  double? intent,
  double? endIntent,
}) {
  return Divider(
    color: bgColor,
    thickness: thikness ?? 1,
    indent: intent ?? 10,
    endIndent: endIntent ?? 10,
  );
}
