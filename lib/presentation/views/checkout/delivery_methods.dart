import 'package:flutter/material.dart';
import 'package:online_shopping/presentation/views/checkout/checkout_screen.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';

import '../../../model/order_model.dart';
import '../../../token/app_colors.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/empty_space.dart';
import '../components/local_images.dart';

class DeliveryMethodWidget extends StatelessWidget {
  final DeliveryMethods deliveryMethods;

  const DeliveryMethodWidget({super.key, required this.deliveryMethods});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.08), // Shadow color
            spreadRadius: 0.0, // Spread radius
            blurRadius: 25.0, // Blur radius
            offset: const Offset(0, 1), // Offset
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LocalImage(
            imagePath: deliveryMethods.image,
          ),
          putVerticalSpace(AppSpacing.sp_11),
          ReusableText(
            text: deliveryMethods.date,
            textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: FontsSizesManager.s11, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
