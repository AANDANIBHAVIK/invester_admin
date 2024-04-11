import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'text_widget.dart';

class CustomFormTextField extends StatelessWidget {
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
  final void Function()? onFileTap;
  final void Function(dynamic)? onChange;
  final Widget? suffixIcon;
  final Color borderColor;
  final bool isDropDown;
  final int maxLine;
  final bool isFile;
  final List<String>? dropDownItems;
  final Map<String, String>? dropDownItemsMap;
  final RxString? selectedItem;

  // final PhoneNumber? number;

  const CustomFormTextField({
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
    this.onFileTap,
    this.onChange,
    this.suffixIcon,
    this.maxLine = 1,
    this.borderColor = Colors.transparent,
    this.isPhone = false,
    this.isDropDown = false,
    this.isFile = false,
    this.dropDownItems,
    this.selectedItem,
    this.dropDownItemsMap,
    // this.number
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15),
          color: context.theme.cardColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            label,
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              SizedBox(
                child: !isDropDown
                    ? TextFormField(
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
                          filled: false,
                          isDense: true,
                          fillColor: textFieldBgColor,
                          hintStyle:
                              TextStyle(color: textLightColor, fontSize: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5, color: Colors.blueAccent),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5, color: Colors.blueAccent),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        maxLines: maxLine,
                      )
                    : FormField<String>(
                        validator: validator,
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              hintText: hint,
                              filled: false,
                              isDense: true,
                              fillColor: textFieldBgColor,
                              hintStyle: TextStyle(
                                  color: textLightColor, fontSize: 16),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.blueAccent),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.blueAccent),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            // isEmpty: _currentSelectedValue == '',
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  // padding: EdgeInsets.only(right: 10),
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  value: selectedItem!.value,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    selectedItem?.value = newValue!;
                                    if (onChange != null) {
                                      onChange!(newValue!);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  items: dropDownItems != null
                                      ? dropDownItems!.map((map) {
                                          return DropdownMenuItem<String>(
                                            value: map,
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(map),
                                          );
                                        }).toList()
                                      : dropDownItemsMap!.entries
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.key,
                                                child: Container(
                                                  child: Text(
                                                    item.value,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                ),
                              ),
                            ),
                          );
                        },
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
