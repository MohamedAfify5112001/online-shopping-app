import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import '../components/text_component.dart';

class CollectionBanners extends StatelessWidget {
  const CollectionBanners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LocalImage(
          imagePath: 'assets/images/image2.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 366.0,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 187.0.h,
                    color: AppColors.whiteColor,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0.w),
                      child: Center(
                        child: ReusableText(
                          text: 'Summer sale',
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      LocalImage(
                        imagePath: 'assets/images/image3.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 207.0.h,
                      ),
                      Positioned(
                        bottom: AppSpacing.sp_37,
                        left: AppSpacing.sp_8,
                        child: ReusableText(
                          text: 'Black',
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const LocalImage(
                    imagePath: 'assets/images/image1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sp_37),
                    child: ReusableText(
                      text: 'Men’s hoodies',
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
