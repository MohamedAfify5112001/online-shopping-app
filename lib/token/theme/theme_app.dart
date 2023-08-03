import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/text_theme.dart';
import 'package:online_shopping/token/theme/text_weights.dart';

OutlineInputBorder getOutlineInputBorder({required Color color}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
      borderSide: BorderSide(color: color, width: 2.w),
    );

InputDecorationTheme getInputDecorationTheme() => InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor,
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 20.0.w),
      enabledBorder: getOutlineInputBorder(color: AppColors.whiteColor),
      focusedBorder: getOutlineInputBorder(color: AppColors.whiteColor),
      errorBorder: getOutlineInputBorder(color: AppColors.errorColor),
      focusedErrorBorder: getOutlineInputBorder(color: AppColors.errorColor),
    );

ThemeData getAppTheme() => ThemeData(
      useMaterial3: true,
      checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: AppColors.greyColor, width: 2.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: AppColors.greyColor,
        selectedItemColor: AppColors.primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: getMediumStyle(
            color: AppColors.blackColor, fontSize: FontsSizesManager.s10),
        selectedLabelStyle: getMediumStyle(
            color: AppColors.primaryColor, fontSize: FontsSizesManager.s10),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        // shadowColor: AppColors.primaryColor,
        // elevation: 3.5,
        elevation: 0.0,
      )),
      hoverColor: AppColors.greyColor.withOpacity(0.5),
      inputDecorationTheme: getInputDecorationTheme(),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.whiteColor,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: FontFamily.$FontFamily,
      cardTheme: CardTheme(color: AppColors.whiteColor),
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark)),
      textTheme: getTextTheme(),
    );
