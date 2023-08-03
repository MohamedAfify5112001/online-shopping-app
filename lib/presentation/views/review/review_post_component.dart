import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/components/rating_bars.dart';
import 'package:online_shopping/presentation/views/components/remote_image.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import '../components/empty_space.dart';

class ReviewPostComponent extends StatelessWidget {
  final bool isShowPhoto;

  const ReviewPostComponent({Key? key, required this.isShowPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        Container(
          width: 311.0.w,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.05), // Shadow color
                  spreadRadius: 0.0, // Spread radius
                  blurRadius: 25.0, // Blur radius
                  offset: const Offset(0, 1), // Offset
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 23.75,
              horizontal: AppSpacing.sp_24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: 'Helene Moored',
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: FontsSizesManager.s14,
                      ),
                ),
                putVerticalSpace(AppSpacing.sp_3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ReusableRatingBarForReviews(
                      count: 5,
                      initialRating: 4,
                    ),
                    ReusableText(
                      text:
                          DateFormat.yMMMMd().format(DateTime.now()).toString(),
                      textStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: FontsSizesManager.s11,
                                color: AppColors.greyColor,
                              ),
                    ),
                  ],
                ),
                putVerticalSpace(AppSpacing.sp_11),
                ReusableText(
                  text:
                      '''The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.''',
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 9,
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: FontsSizesManager.s14,
                        color: AppColors.blackColor,
                      ),
                ),
                isShowPhoto
                    ? Column(
                        children: [
                          putVerticalSpace(AppSpacing.sp_12),
                          SizedBox(
                            height: 104.0,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    const ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      child: RemoteImage(
                                          fit: BoxFit.cover,
                                          width: 104.0,
                                          height: 104.0,
                                          imagePath:
                                              'https://st3.depositphotos.com/1037987/15097/i/600/depositphotos_150975580-stock-photo-portrait-of-businesswoman-in-office.jpg'),
                                    ),
                                separatorBuilder: (context, index) =>
                                    putHorizontalSpace(AppSpacing.sp_16),
                                itemCount: 5),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
        Positioned(
          top: -16,
          left: -16,
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: CircleAvatar(
              backgroundColor: AppColors.greyColor,
              backgroundImage: const NetworkImage(
                  'https://st3.depositphotos.com/1037987/15097/i/600/depositphotos_150975580-stock-photo-portrait-of-businesswoman-in-office.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
