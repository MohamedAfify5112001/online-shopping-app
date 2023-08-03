import 'package:flutter/material.dart';
import 'package:online_shopping/model/card_model.dart';
import 'package:online_shopping/presentation/views/checkout/checkout_screen.dart';
import 'package:online_shopping/token/extensions.dart';

import '../../../model/order_model.dart';
import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/empty_space.dart';
import '../components/local_images.dart';
import '../components/text_component.dart';

class MasterPaymentCardWidget extends StatelessWidget {
  final CardModel cardModel;

  const MasterPaymentCardWidget({
    super.key,
    required this.cardModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Routing.goBack(
                context,
                PaymentCard(
                    cardNumber: cardModel.cardNumber,
                    isMasterOrVisa: cardModel.isMasterCardOrVisa));
          },
          child: Container(
            width: double.infinity,
            height: 216.0,
            decoration: BoxDecoration(
              color: AppColors.blackColor,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.34),
                  // Shadow color
                  spreadRadius: 0.0,
                  // Spread radius
                  blurRadius: 25.0,
                  // Blur radius
                  offset: const Offset(0, 1), // Offset
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned(
                  bottom: -10,
                  left: -8,
                  child: LocalImage(
                    imagePath: 'assets/images/vector1.png',
                  ),
                ),
                const Positioned(
                  top: -10,
                  right: -8,
                  child: LocalImage(
                    imagePath: 'assets/images/vector2.png',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.sp_24),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LocalImage(
                          imagePath: 'assets/images/chip.png',
                        ),
                        putVerticalSpace(AppSpacing.sp_24),
                        ReusableText(
                          text: cardModel.cardNumber.maskCardNumber,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: FontsSizesManager.s24,
                                  color: AppColors.whiteColor),
                        ),
                        putVerticalSpace(AppSpacing.sp_43),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ReusableText(
                                  text: 'Card Holder Name',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s10,
                                          color: AppColors.whiteColor),
                                ),
                                ReusableText(
                                  text: cardModel.nameOnCard,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14,
                                          color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ReusableText(
                                  text: cardModel.expireDate,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s10,
                                          color: AppColors.whiteColor),
                                ),
                                ReusableText(
                                  text: '05/23',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14,
                                          color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                            const LocalImage(
                              imagePath: 'assets/images/mastercard.png',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        putVerticalSpace(AppSpacing.sp_25),
        Row(
          children: [
            Checkbox(
              value: cardModel.isDefault,
              visualDensity: VisualDensity.compact,
              onChanged: (value) {},
              activeColor: AppColors.blackColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            ReusableText(
                text: 'Use as default payment method',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: FontsSizesManager.s14)),
          ],
        ),
      ],
    );
  }
}

class VisaPaymentCardWidget extends StatelessWidget {
  final CardModel cardModel;

  const VisaPaymentCardWidget({
    super.key,
    required this.cardModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Routing.goBack(
                context,
                PaymentCard(
                    cardNumber: cardModel.cardNumber,
                    isMasterOrVisa: cardModel.isMasterCardOrVisa));
          },
          child: Container(
            width: double.infinity,
            height: 216.0,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.34),
                  // Shadow color
                  spreadRadius: 0.0,
                  // Spread radius
                  blurRadius: 25.0,
                  // Blur radius
                  offset: const Offset(0, 1), // Offset
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned(
                  bottom: -10,
                  left: -8,
                  child: LocalImage(
                    imagePath: 'assets/images/vector1.png',
                  ),
                ),
                const Positioned(
                  top: -10,
                  right: -8,
                  child: LocalImage(
                    imagePath: 'assets/images/vector2.png',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.sp_24),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        putVerticalSpace(AppSpacing.sp_2),
                        const Row(
                          children: [
                            Spacer(),
                            LocalImage(
                              imagePath: 'assets/images/visa.png',
                            ),
                          ],
                        ),
                        putVerticalSpace(AppSpacing.sp_32),
                        ReusableText(
                          text: cardModel.cardNumber.maskCardNumber,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: FontsSizesManager.s24,
                                  color: AppColors.whiteColor),
                        ),
                        putVerticalSpace(AppSpacing.sp_6),
                        const LocalImage(
                          imagePath: 'assets/images/chip.png',
                        ),
                        putVerticalSpace(AppSpacing.sp_17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ReusableText(
                                  text: 'Card Holder Name',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s10,
                                          color: AppColors.whiteColor),
                                ),
                                ReusableText(
                                  text: cardModel.nameOnCard,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14,
                                          color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ReusableText(
                                  text: 'Expiry Date',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s10,
                                          color: AppColors.whiteColor),
                                ),
                                ReusableText(
                                  text: cardModel.expireDate,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14,
                                          color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        putVerticalSpace(AppSpacing.sp_25),
        Row(
          children: [
            Checkbox(
              value: cardModel.isDefault,
              visualDensity: VisualDensity.compact,
              onChanged: (value) {},
              activeColor: AppColors.blackColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            ReusableText(
                text: 'Use as default payment method',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: FontsSizesManager.s14)),
          ],
        ),
      ],
    );
  }
}
