import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/remote_image.dart';
import 'package:online_shopping/presentation/views/shop/product_details.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../../view_model/product/product_bloc.dart';
import '../components/rating_bars.dart';
import '../components/text_component.dart';

class HorizontalProductItem extends StatefulWidget {
  final Product product;

  const HorizontalProductItem({Key? key, required this.product})
      : super(key: key);

  @override
  State<HorizontalProductItem> createState() => _HorizontalProductItemState();
}

class _HorizontalProductItemState extends State<HorizontalProductItem> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => PageTransition(
            child: ProductDetails(product: widget.product),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
          ),
          child: Container(
            width: double.infinity,
            height: 123.0,
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
                ]),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    PageTransition(
                      child: ProductDetails(product: widget.product),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 800),
                      reverseDuration: const Duration(milliseconds: 800),
                    ),
                  ),
                  child: RemoteImage(
                    imagePath: widget.product.image,
                    fit: BoxFit.cover,
                    width: 104.0,
                    height: 123.0,
                  ),
                ),
                putHorizontalSpace(11.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: widget.product.name,
                          textOverflow: TextOverflow.ellipsis,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: FontsSizesManager.s16),
                        ),
                        putVerticalSpace(4.0),
                        ReusableText(
                          text: widget.product.desc,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: FontsSizesManager.s11,
                                  color: AppColors.greyColor),
                        ),
                        putVerticalSpace(8.0),
                        Row(
                          children: [
                            ReusableRatingBar(
                                initialRating: widget.product.rate),
                            putHorizontalSpace(AppSpacing.sp_2),
                            ReusableText(
                              text: '(${widget.product.rate})',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: FontsSizesManager.s10,
                                      color: AppColors.greyColor),
                            ),
                          ],
                        ),
                        putVerticalSpace(8.0),
                        Row(
                          children: [
                            ReusableText(
                              text: '\$${widget.product.price}',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: FontsSizesManager.s14,
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.greyColor),
                            ),
                            putHorizontalSpace(AppSpacing.sp_4),
                            ReusableText(
                              text: '\$${widget.product.discountPrice}',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: FontsSizesManager.s14,
                                      color: AppColors.primaryColor),
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
        Transform.translate(
          offset: const Offset(339, 100),
          child: GestureDetector(
            onTap: () {
              if (widget.product.isFavorite) {
                setState(() => widget.product.isFavorite = false);
                context
                    .read<ProductBloc>()
                    .add(DeleteProductInFavEvent(widget.product));
              } else {
                setState(() {
                  isFav = !isFav;
                });
                setState(() {
                  widget.product.isFavorite = isFav;
                });
                if (widget.product.isFavorite) {
                  context
                      .read<ProductBloc>()
                      .add(AddProductInFavEvent(widget.product));
                } else {
                  context
                      .read<ProductBloc>()
                      .add(DeleteProductInFavEvent(widget.product));
                }
              }
            },
            child: Container(
              width: 36.0.w,
              height: 36.0.h,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(0.08),
                      // Shadow color
                      spreadRadius: 0.0,
                      // Spread radius
                      blurRadius: 4.0,
                      // Blur radius
                      offset: Offset(0.w, 4.h), // Offset
                    ),
                  ]),
              child: Center(
                child: Icon(
                  widget.product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: widget.product.isFavorite
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
