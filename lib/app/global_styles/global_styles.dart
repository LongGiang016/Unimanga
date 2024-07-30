import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimanga_app/app/constants/index.dart';
class GlobalStyles {
  static TextStyle stylesTitleAppBar(isDarkMode) {
    return TextStyle(
        fontSize: 24,
        fontFamily: AppFonts.verLag,
        color: isDarkMode ? Colors.white : Color(0xffB03CB4));
  }

  static final TextStyle stylesTitleAppBarNoColor =
      TextStyle(fontSize: 24, color: Colors.white, fontFamily: AppFonts.verLag);

  static final EdgeInsets paddingPageLeftRight =
      EdgeInsets.symmetric(horizontal: 12);
  static final EdgeInsets paddingPageLeftRight_15 =
      EdgeInsets.symmetric(horizontal: 15);
  static final EdgeInsets paddingPageLeftRight_25 =
      EdgeInsets.symmetric(horizontal: 25);
  static final EdgeInsets paddingAll = EdgeInsets.all(12);

  static final SizedBox sizedBoxHeight_10 = SizedBox(
    height: 10,
  );
  static final SizedBox sizedBoxHeight_5 = SizedBox(
    height: 5,
  );
  static final SizedBox sizedBoxHeight = SizedBox(
    height: 15,
  );
  static final SizedBox sizedBoxHeight_30 = SizedBox(
    height: 30,
  );
  static final SizedBox sizedBoxWidth_10 = SizedBox(
    width: 10,
  );
  static final SizedBox sizedBoxWidth_5 = SizedBox(
    width: 5,
  );
  static final SizedBox sizedBoxWidth = SizedBox(
    width: 15,
  );
  static final SizedBox sizedBoxWidth_30 = SizedBox(
    width: 30,
  );
}
