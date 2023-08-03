import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/spacing.dart';

class ReusableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final bool isPadding;

  const ReusableButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.textStyle,
    this.isPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.25), // Shadow color
            spreadRadius: 0.0, // Spread radius
            blurRadius: 8.0, // Blur radius
            offset: Offset(0.w, 4.h), // Offset
          ),
        ],
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: isPadding
                ? const EdgeInsets.symmetric(vertical: AppSpacing.sp_14)
                : EdgeInsets.zero,
            child: ReusableText(
              text: text,
              textStyle: textStyle,
            ),
          )),
    );
  }
}
