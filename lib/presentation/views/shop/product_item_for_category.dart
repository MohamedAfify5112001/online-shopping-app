import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/presentation/views/shop/product_details.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:page_transition/page_transition.dart';
import '../../../token/app_colors.dart';
import '../../../token/theme/spacing.dart';
import '../../view_model/product/product_bloc.dart';
import '../components/empty_space.dart';
import '../components/rating_bars.dart';
import '../components/remote_image.dart';

class ProductItemForCategory extends StatefulWidget {
  final Product product;

  const ProductItemForCategory({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductItemForCategory> createState() => _ProductItemForCategoryState();
}

class _ProductItemForCategoryState extends State<ProductItemForCategory> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.0,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        PageTransition(
                          child: ProductDetails(product: widget.product),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 800),
                          reverseDuration: const Duration(milliseconds: 800),
                        ),
                      ),
                      child: RemoteImage(
                          fit: BoxFit.cover,
                          height: 184.0,
                          width: 400,
                          imagePath: widget.product.image),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    top: 8.0,
                    child: Container(
                      width: 40.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(29.0),
                        ),
                      ),
                      child: Center(
                        child: ReusableText(
                          text: '${widget.product.discountRate}%',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: FontsSizesManager.s11,
                                  color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_7),
              SizedBox(
                height: 14.0,
                child: Row(
                  children: [
                    ReusableRatingBar(initialRating: widget.product.rate),
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
              ),
              putVerticalSpace(AppSpacing.sp_6),
              ReusableText(
                text: widget.product.desc,
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: FontsSizesManager.s11,
                    color: AppColors.greyColor),
              ),
              putVerticalSpace(AppSpacing.sp_5),
              ReusableText(
                text: widget.product.name,
                textOverflow: TextOverflow.ellipsis,
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: FontsSizesManager.s16),
              ),
              putVerticalSpace(AppSpacing.sp_3),
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
          Positioned(
            top: 164.0,
            left: 142.0,
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
      ),
    );
  }
}
