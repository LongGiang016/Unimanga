import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unimanga_app/app/constants/index.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    this.decoration,
    this.hintText,
    this.controller,
    this.inputType,
    this.inputAction,
    this.validator,
    this.onChangeFunction,
    this.inputFormatCustom,
    this.maxLengthText,
    this.maxLines,
    this.fontSize,
    this.suffixIcon,
    this.borderRadius,
    this.colorBorder,
  }) : super(key: key);

  final String? hintText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final controller;
  final String? Function(String?)? validator;
  final Function(String)? onChangeFunction;
  final FilteringTextInputFormatter? inputFormatCustom;
  final int? maxLengthText;
  final int? maxLines;
  final double? fontSize;
  final double? borderRadius;
  final Color? colorBorder;
  final suffixIcon;
  final InputDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppColors.gray,
        filled: true,
        counterText: "",
        isDense: true,
        // errorStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5), fontSize: fontSize ?? 14),
        contentPadding: EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorBorder ?? AppColors.lightBlack,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 14)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenPrimary),
            borderRadius: BorderRadius.circular(borderRadius ?? 14)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius ?? 14)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius ?? 14)),
        suffixIcon: suffixIcon ?? null,
      ),
      style: TextStyle(color: Colors.black, fontSize: fontSize ?? 14),
      controller: controller,
      // validator: validator,
      inputFormatters: [
        inputFormatCustom ?? FilteringTextInputFormatter.singleLineFormatter
      ],
      textAlign: TextAlign.start,
      maxLines: maxLines ?? 1,
      maxLength: maxLengthText ?? null,
      autofocus: false,
      keyboardType: inputType,
      textInputAction: inputAction,
      onChanged: onChangeFunction,
      validator: validator,
    );
  }
}
