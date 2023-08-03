import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/text_weights.dart';

import 'font_sizes.dart';

TextStyle _makeTextStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
}) =>
    TextStyle(fontSize: fontSize.sp, fontWeight: fontWeight, color: color);

// Light Style
TextStyle getLightStyle(
    {double fontSize = FontsSizesManager.s11,
    FontWeight fontWeight = FontsWeightManager.$MetropolisLight,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

// Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontsSizesManager.s16,
    FontWeight fontWeight = FontsWeightManager.$MetropolisRegular,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getMediumStyle(
    {double fontSize = FontsSizesManager.s16,
    FontWeight fontWeight = FontsWeightManager.$MetropolisMed,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getBoldStyle(
    {double fontSize = FontsSizesManager.s16,
    FontWeight fontWeight = FontsWeightManager.$MetropolisBold,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getBlackStyle(
    {double fontSize = FontsSizesManager.s34,
    FontWeight fontWeight = FontsWeightManager.$MetropolisBlack,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextStyle getExtraBoldStyle(
    {double fontSize = FontsSizesManager.s34,
    FontWeight fontWeight = FontsWeightManager.$MetropolisExtraBold,
    required Color color}) {
  final TextStyle textStyle =
      _makeTextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

TextTheme getTextTheme() => TextTheme(
      headlineLarge: getExtraBoldStyle(color: AppColors.blackColor),
      displayLarge: getBlackStyle(color: AppColors.blackColor),
      titleLarge: getBoldStyle(color: AppColors.blackColor),
      titleMedium: getMediumStyle(color: AppColors.blackColor),
      titleSmall: getRegularStyle(color: AppColors.blackColor),
    );
