import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unimanga_app/app/constants/index.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin(
      {Key? key,
      this.hintText,
      this.controller,
      this.inputType,
      this.inputAction,
      this.validator,
      this.onChangeFunction,
      this.inputFormatCustom,
      this.maxLengthText})
      : super(key: key);

  final String? hintText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final controller;
  final String? Function(String?)? validator;
  final Function(String)? onChangeFunction;
  final FilteringTextInputFormatter? inputFormatCustom;
  final int? maxLengthText;

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
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        contentPadding: EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.lightBlack,
            ),
            borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenPrimary),
            borderRadius: BorderRadius.circular(14)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(14)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(14)),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16),
      controller: controller,
      // validator: validator,
      inputFormatters: [
        inputFormatCustom ?? FilteringTextInputFormatter.singleLineFormatter
      ],
      textAlign: TextAlign.start,
      maxLines: 1,
      maxLength: maxLengthText ?? null,
      autofocus: false,

      keyboardType: inputType,
      textInputAction: inputAction,
      onChanged: onChangeFunction,
    );
  }
}
