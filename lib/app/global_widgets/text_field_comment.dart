import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class TextFieldComment extends StatelessWidget {
  const TextFieldComment({
    Key? key,
    required this.controller,
    this.hintText,
    this.borderColor,
    this.iconColor,
    this.onChange,
    this.height,
    this.autofocus,
    this.width,
    this.onPressed,
  }) : super(key: key);
  final controller;
  final height;
  final width;
  final String? hintText;
  final Color? borderColor;
  final iconColor;
  final onChange;
  final onPressed;
  final autofocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              autofocus: autofocus ?? false,
              decoration: InputDecoration(
                hintText: hintText ?? "",
                fillColor: Color(0xffF2F2F2),
                filled: true,
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                isDense: true,
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: borderColor ?? AppColors.gray),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: borderColor ?? AppColors.greenPrimary),
                    borderRadius: BorderRadius.circular(20)),
              ),
              style: TextStyle(color: AppColors.black, fontSize: 16),
              controller: controller,
              textAlign: TextAlign.start,
              maxLines: null,
              onChanged: onChange,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 25,
            ),
            color: iconColor ?? AppColors.black,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
