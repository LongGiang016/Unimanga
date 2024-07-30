import 'package:flutter/material.dart';
import 'package:unimanga_app/app/constants/index.dart';

class PasswordCustom extends StatefulWidget {
  const PasswordCustom(
      {Key? key,
      this.hintText,
      required this.inputType,
      required this.controller,
      this.inputAction,
      this.onChangeFunction,
      this.validator,
      this.fontSize})
      : super(key: key);
  final String? hintText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final controller;
  final String? Function(String?)? validator;
  final Function(String)? onChangeFunction;
  final double? fontSize;

  @override
  _PassWordCustomState createState() => _PassWordCustomState();
}

class _PassWordCustomState extends State<PasswordCustom> {
  var _secureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: AppColors.gray,
        filled: true,
        errorMaxLines: 3,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        isDense: true,
        contentPadding: EdgeInsets.all(20),

        // errorStyle: TextStyle(color: Colors.white),
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
      style: TextStyle(color: Colors.black, fontSize: widget.fontSize ?? 16),
      controller: widget.controller,
      // validator: widget.validator,
      maxLines: 1,
      textAlign: TextAlign.start,
      obscureText: _secureText,
      keyboardType: widget.inputType,
      textInputAction: widget.inputAction,
      onChanged: widget.onChangeFunction,
    );
  }
}
