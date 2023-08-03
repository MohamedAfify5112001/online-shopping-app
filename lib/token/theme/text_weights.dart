import 'package:flutter/material.dart';

sealed class FontFamily {
  FontFamily._();

  static const String $FontFamily = "Metropolis";
}

sealed class FontsWeightManager {
  FontsWeightManager._();

  static const FontWeight $MetropolisExtraBold = FontWeight.w800;
  static const FontWeight $MetropolisBold = FontWeight.w700;
  static const FontWeight $MetropolisBlack = FontWeight.w600;
  static const FontWeight $MetropolisMed = FontWeight.w500;
  static const FontWeight $MetropolisRegular = FontWeight.w400;
  static const FontWeight $MetropolisLight = FontWeight.w300;
}
