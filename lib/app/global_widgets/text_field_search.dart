import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    Key? key,
    required this.controller,
    this.hintText,
    this.borderColor,
    this.iconColor,
    this.onChange,
    this.height,
    this.width,
    this.autofocus,
    this.readOnly,
  }) : super(key: key);
  final controller;
  final height;
  final width;
  final String? hintText;
  final Color? borderColor;
  final iconColor;
  final onChange;
  final autofocus;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? 250,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText ?? "",
          fillColor: Color(0xffF2F2F2),
          filled: true,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search,
              color: iconColor ?? AppColors.black,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 30,
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColors.gray),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor ?? AppColors.greenPrimary),
              borderRadius: BorderRadius.circular(20)),
        ),
        style: TextStyle(color: AppColors.black, fontSize: 16),
        controller: controller,
        textAlign: TextAlign.start,
        maxLines: 1,
        onChanged: onChange,
        autofocus: autofocus ?? false,
        readOnly: readOnly ?? false,
      ),
    );
  }
}
