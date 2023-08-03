import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shopping/presentation/views/components/btn_comp.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/rating_bars.dart';
import 'package:online_shopping/presentation/views/review/review_post_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import '../../../model/product_model.dart';
import '../../../token/routing.dart';
import '../components/text_component.dart';

class ReviewScreen extends StatefulWidget {
  final Product product;

  const ReviewScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool showPhoto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sp_24),
        child: SizedBox(
          height: 36.0,
          child: FloatingActionButton.extended(
              backgroundColor: AppColors.primaryColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              elevation: 0.0,
              onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => _buildWritingReview(context)),
              label: buildFloatingActionButtonLabel()),
        ),
      ),
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sp_14),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              putVerticalSpace(AppSpacing.sp_18),
              ReusableText(
                  text: 'Rating&Reviews',
                  textStyle: Theme.of(context).textTheme.displayLarge!),
              putVerticalSpace(AppSpacing.sp_41),
              Row(
                children: [
                  _buildRatings(context),
                  putHorizontalSpace(AppSpacing.sp_28),
                  _buildRatingBars(context),
                  putHorizontalSpace(AppSpacing.sp_20),
                  _buildBarReview(context),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_33),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                      text: '8 reviews',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s24)),
                  _buildShowWithPhoto(),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_28),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Center(
                    child: ReviewPostComponent(
                  isShowPhoto: showPhoto,
                )),
                itemCount: 6,
                separatorBuilder: (context, index) =>
                    putVerticalSpace(AppSpacing.sp_31),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildFloatingActionButtonLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sp_15),
      child: Row(
        children: [
          Icon(
            Icons.edit,
            color: AppColors.whiteColor,
            size: 24.0,
          ),
          putHorizontalSpace(AppSpacing.sp_4),
          ReusableText(
              text: 'Write a review',
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: FontsSizesManager.s11,
                  color: AppColors.whiteColor)),
        ],
      ),
    );
  }

  Widget _buildShowWithPhoto() => Builder(
        builder: (context) => Row(
          children: [
            Checkbox(
              value: showPhoto,
              onChanged: (value) => setState(() => showPhoto = value!),
              activeColor: AppColors.blackColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            ReusableText(
                text: 'With photo',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: FontsSizesManager.s14)),
          ],
        ),
      );

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
        onPressed: () => Routing.goBack(context),
      ),
    );
  }

  Widget _buildRatings(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ReusableText(
              text: ((widget.product.rate) / 2.2).toDouble().toStringAsFixed(1),
              textStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: FontsSizesManager.s44)),
          ReusableText(
              text: '23 ratings',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontsSizesManager.s14, color: AppColors.greyColor)),
        ],
      );

  Widget _buildRatingBars(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: index != 4 ? 10.8 : 0),
            child: ReusableRatingBarForReviews(
                initialRating: 5, count: (5 - index)),
          ),
        ),
      );

  Widget _buildBarReview(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 114.0,
                height: 8.0,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              ),
              putHorizontalSpace(AppSpacing.sp_18),
              ReusableText(
                  text: '12',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: FontsSizesManager.s14))
            ],
          ),
          putVerticalSpace(AppSpacing.sp_2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40.0,
                height: 8.0,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              ),
              putHorizontalSpace(90.0),
              ReusableText(
                  text: '5',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: FontsSizesManager.s14))
            ],
          ),
          putVerticalSpace(AppSpacing.sp_2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 29.0,
                height: 8.0,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              ),
              putHorizontalSpace(100.0),
              ReusableText(
                  text: '4',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: FontsSizesManager.s14))
            ],
          ),
          putVerticalSpace(AppSpacing.sp_2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 15.0,
                height: 8.0,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              ),
              putHorizontalSpace(113.0),
              ReusableText(
                  text: '2',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: FontsSizesManager.s14))
            ],
          ),
          putVerticalSpace(AppSpacing.sp_2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              ),
              putHorizontalSpace(119.0),
              ReusableText(
                  text: '0',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: FontsSizesManager.s14))
            ],
          ),
        ],
      );

  Widget _buildWritingReview(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(34.0),
                topRight: Radius.circular(34.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ReusableText(
                      text: 'What is you rate?',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s18)),
                ),
                putVerticalSpace(AppSpacing.sp_8),
                Center(
                  child: RatingBar.builder(
                    initialRating: 0.0,
                    minRating: 1,
                    maxRating: 10,
                    direction: Axis.horizontal,
                    itemSize: 36.0,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rounded,
                      color: AppColors.ratingColor,
                    ),
                    onRatingUpdate: (double value) {
                      if (kDebugMode) {
                        print(value);
                      }
                    },
                  ),
                ),
                putVerticalSpace(AppSpacing.sp_33),
                Center(
                  child: ReusableText(
                      text: 'Please share your opinion\n about the product',
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s18)),
                ),
                putVerticalSpace(AppSpacing.sp_18),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.05),
                          // Shadow color
                          spreadRadius: 0.0,
                          // Spread radius
                          blurRadius: 8.0,
                          // Blur radius
                          offset: const Offset(0, 1), // Offset
                        )
                      ]),
                  child: TextFormField(
                    maxLines: 6,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      hintText: 'Your review',
                      border: InputBorder.none,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              color: AppColors.greyColor,
                              fontSize: FontsSizesManager.s14),
                    ),
                  ),
                ),
                putVerticalSpace(AppSpacing.sp_30),
                Container(
                  height: 104.0,
                  width: 104.0,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.16),
                          // Shadow color
                          spreadRadius: 0.0,
                          // Spread radius
                          blurRadius: 16.0,
                          // Blur radius
                          offset: const Offset(0, 1), // Offset
                        )
                      ]),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.sp_6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          height: 52.0,
                          width: 52.0,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.whiteColor,
                            size: 24.0,
                          ),
                        ),
                        putVerticalSpace(AppSpacing.sp_12),
                        ReusableText(
                            text: 'Add your photos',
                            textAlign: TextAlign.center,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: FontsSizesManager.s10)),
                      ],
                    ),
                  ),
                ),
                putVerticalSpace(AppSpacing.sp_35),
                SizedBox(
                  width: double.infinity,
                  child: ReusableButton(
                      onPressed: () {},
                      text: 'SEND REVIEW',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.whiteColor)),
                )
              ],
            ),
          ),
        ),
      );
}

List<int> _numbers = [12, 5, 4, 2, 0];
