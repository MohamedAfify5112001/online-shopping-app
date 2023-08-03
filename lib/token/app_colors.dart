import 'package:flutter/material.dart';
import 'package:online_shopping/token/extensions.dart';

sealed class AppColors {
  AppColors._();

  static Color primaryColor = '#DB3022'.toColor();
  static Color greyColor = '#9B9B9B'.toColor();
  static Color blackColor = '#222222'.toColor();
  static Color backgroundColor = '#F9F9F9'.toColor();
  static Color whiteColor = '#FFFFFF'.toColor();
  static Color errorColor = '#F01F0E'.toColor();
  static Color successColor = '#2AA952'.toColor();
  static Color ratingColor = '#FFBA49'.toColor();
}
