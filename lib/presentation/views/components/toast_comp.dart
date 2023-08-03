import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';

enum ToastMessage { errorToast, successToast }

Future<void> getToastMessage(
        {required String msg, required ToastMessage toastMessage}) =>
    Fluttertoast.showToast(
        msg: msg,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: toastMessage == ToastMessage.successToast
            ? AppColors.successColor
            : AppColors.errorColor,
        textColor: Colors.white,
        fontSize: FontsSizesManager.s12);
