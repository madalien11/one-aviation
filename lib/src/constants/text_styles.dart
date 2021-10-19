import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle seaplanesTitleTextStyle = GoogleFonts.mrsSheppards(
  textStyle: TextStyle(
    fontSize: 80,
    color: SeaplanesTitleTextColor.withOpacity(0.7),
    height: 107 / 80,
    fontWeight: FontWeight.w400,
  ),
);

class MyTextStyle {
  static googleFontWrapper(TextStyle ts) {
    return GoogleFonts.poppins(textStyle: ts);
  }

  static const TextStyle PlaceholderTextStyle = TextStyle(
    fontSize: 15,
    color: PlaceholderGrayColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle TitleTextStyle = TextStyle(
    fontSize: 18,
    color: BlackTitleTextColor,
    height: 1.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle OneAviationTitleTextStyle = TextStyle(
    fontSize: 18,
    color: BlackTitleTextColor,
    height: 1.5,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle SeaplanesSubtitleTextStyle = TextStyle(
    fontSize: 12,
    color: SeaplanesTitleTextColor,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle TextFieldTextStyle = TextStyle(
    color: PrimaryDarkTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle CardTitleTextStyle = TextStyle(
    fontSize: 14,
    color: BlackTitleTextColor,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle CardSubtitleTextStyle = TextStyle(
    fontSize: 12,
    color: BlackTitleTextColor,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle OrangeTitleTextStyle = TextStyle(
    fontSize: 28,
    color: PrimaryOrangeColor,
    height: 1.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle ButtonTextStyle = TextStyle(
    fontSize: 18,
    color: WhiteTitleTextColor,
    height: 1.5,
    letterSpacing: 1,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle TextButtonTextStyle = TextStyle(
    fontSize: 16,
    color: PrimaryOrangeColor,
    height: 1.5,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle ErrorMessageTextStyle = TextStyle(
    fontSize: 16,
    color: PrimaryRedColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle ProfilePlaceholderTextStyle = TextStyle(
    fontSize: 36,
    color: PrimaryOrangeColor,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  static const TextStyle DarkTitleTextStyle = TextStyle(
    color: PrimaryDarkTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
}
