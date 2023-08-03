import 'package:flutter/material.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/app_colors.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/empty_space.dart';
import '../components/remote_image.dart';
import '../components/text_component.dart';
import '../shop/product_details.dart';

class ProductItemForOrder extends StatelessWidget {
  final Product product;
  final int quantity;

  const ProductItemForOrder(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 104.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 25.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              PageTransition(
                child: ProductDetails(product: product),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 800),
                reverseDuration: const Duration(milliseconds: 800),
              ),
            ),
            child: RemoteImage(
              imagePath: product.image,
              fit: BoxFit.cover,
              width: 104.0,
              height: 104.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 6.0, horizontal: AppSpacing.sp_11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: product.name,
                    textOverflow: TextOverflow.ellipsis,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: FontsSizesManager.s16),
                  ),
                  ReusableText(
                    text: product.desc,
                    textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: FontsSizesManager.s11,
                        color: AppColors.greyColor),
                  ),
                  putVerticalSpace(AppSpacing.sp_6),
                  Row(
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: 'Color: ',
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: FontsSizesManager.s11,
                                    color: AppColors.greyColor),
                          ),
                          ReusableText(
                            text: product.color,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: FontsSizesManager.s11),
                          ),
                          putHorizontalSpace(AppSpacing.sp_13),
                          Row(
                            children: [
                              ReusableText(
                                text: 'Size: ',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: FontsSizesManager.s11,
                                        color: AppColors.greyColor),
                              ),
                              ReusableText(
                                text: product.size,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: FontsSizesManager.s11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  putVerticalSpace(AppSpacing.sp_6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: 'Units: ',
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: FontsSizesManager.s11,
                                    color: AppColors.greyColor),
                          ),
                          ReusableText(
                            text: quantity.toString(),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: FontsSizesManager.s11),
                          ),
                        ],
                      ),
                      ReusableText(
                        text: '${product.discountPrice}\$',
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: FontsSizesManager.s14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
