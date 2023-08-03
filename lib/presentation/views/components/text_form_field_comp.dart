import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../token/app_colors.dart';
import '../../../token/theme/font_sizes.dart';

class ReusableTextFormField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? colorSuffixIcon;
  final VoidCallback? onPressed;
  final bool? obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final Widget? suffixIconImage;
  final List<TextInputFormatter>? inputFormatters;

  const ReusableTextFormField(
      {Key? key,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.onPressed,
      this.obscureText,
      required this.controller,
      required this.keyboardType,
      this.validator,
      this.focusNode,
      this.onChanged,
      this.colorSuffixIcon,
      this.suffixIconImage,
      this.inputFormatters})
      : super(key: key);

  @override
  State<ReusableTextFormField> createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.05), // Shadow color
            spreadRadius: 0.0, // Spread radius
            blurRadius: 8.0, // Blur radius
            offset: Offset(0.w, 1.h), // Offset
          ),
        ],
      ),
      child: TextFormField(
        focusNode: widget.focusNode,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: FontsSizesManager.s14),
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText ?? true,
        inputFormatters: widget.inputFormatters,
        cursorColor: AppColors.primaryColor,
        validator: widget.validator,
        decoration: InputDecoration(
          errorStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.errorColor, fontSize: FontsSizesManager.s11),
          hintText: widget.hintText,
          prefixIconConstraints: BoxConstraints(minWidth: 0.w, minHeight: 0.h),
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.greyColor, fontSize: FontsSizesManager.s14),
          prefixIcon: Icon(widget.prefixIcon, size: 24.0.w),
          suffixIcon: widget.suffixIconImage ??
              (widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                        size: 24.w,
                        color: widget.colorSuffixIcon,
                      ),
                      onPressed: widget.onPressed,
                    )
                  : null),
        ),
      ),
    );
  }
}
