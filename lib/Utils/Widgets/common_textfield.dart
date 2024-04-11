import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'text_widget.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool withAsterisk;
  final TextEditingController? controller;
  final TextEditingController? controllerPhone;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool obscureText;
  final bool isPhone;
  final String? Function(String?)? validator;
  final void Function()? onSuffixTap;
  final void Function(dynamic)? onChange;
  final Widget? suffixIcon;
  final Color borderColor;
  // final PhoneNumber? number;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint = '',
    this.textInputType = TextInputType.text,
    this.withAsterisk = false,
    this.obscureText = false,
    this.inputFormatters,
    this.controller,
    this.controllerPhone,
    this.enabled = true,
    this.validator,
    this.onSuffixTap,
    this.onChange,
    this.suffixIcon,
    this.borderColor = Colors.transparent,
    this.isPhone = false,
    // this.number
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15),
          color: context.theme.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            label,
            color: context.textTheme.headline1!.color!,
            fontSize: 18,
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                onChanged: (val) {
                  if (onChange != null) {
                    onChange!(val);
                  }
                },
                enabled: enabled,
                controller: controller,
                cursorColor: context.theme.primaryColor,
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                validator: validator,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  // isDense: true,
                  fillColor: textFieldBgColor,
                  hintStyle: TextStyle(color: textLightColor, fontSize: 16),
                  suffixIcon: const Text(""),
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 25, maxWidth: 30),

                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              suffixIcon ?? SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
