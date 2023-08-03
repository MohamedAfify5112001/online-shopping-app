import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/token/app_colors.dart';

class ReusableSocial extends StatelessWidget {
  final String imagePath;

  const ReusableSocial({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.0.w,
      height: 64.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24.0.r)),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.05), // Shadow color
            spreadRadius: 0.0, // Spread radius
            blurRadius: 8.0, // Blur radius
            offset: Offset(0.w, 1.h), // Offset
          ),
        ],
      ),
      child: LocalImage(
        imagePath: imagePath,
        height: 24.0.h,
        width: 23.5.w,
      ),
    );
  }
}
