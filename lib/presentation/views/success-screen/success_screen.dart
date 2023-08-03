import 'package:flutter/material.dart';
import 'package:online_shopping/presentation/views/components/btn_comp.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/routing.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import '../../../token/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const LocalImage(
            imagePath: 'assets/images/success_shopping.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100.0,
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReusableText(
                      text: 'Success!',
                      textStyle: Theme.of(context).textTheme.displayLarge!),
                  putVerticalSpace(AppSpacing.sp_16),
                  ReusableText(
                    textAlign: TextAlign.center,
                    text:
                        'Your order will be delivered soon.\nThank you for choosing our app!',
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: FontsSizesManager.s16,
                        ),
                  ),
                  putVerticalSpace(AppSpacing.sp_16),
                  ReusableButton(
                    onPressed: () => Routing.removeWith(context, Routing.layout),
                    text: 'Continue shopping',
                    textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: FontsSizesManager.s14,
                          color: AppColors.whiteColor,
                        ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
