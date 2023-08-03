import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/data/cache/caching_comp.dart';
import 'package:online_shopping/presentation/view_model/product/product_bloc.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/remote_image.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../../../model/product_model.dart';
import '../../../token/theme/font_sizes.dart';
import '../shop/product_details.dart';
import 'rating_bars.dart';

class ReusableProductItems extends StatelessWidget {
  final double height;
  final double width;
  final Axis scrollDirection;
  final List<Product> products;

  const ReusableProductItems(
      {Key? key,
      required this.height,
      required this.scrollDirection,
      required this.products,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: scrollDirection,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => SizedBox(
            width: width, child: ProductItem(product: products[index])),
        separatorBuilder: (context, index) =>
            putHorizontalSpace(AppSpacing.sp_17),
        itemCount: products.length,
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              fontSize: FontsSizesManager.s11, color: AppColors.greyColor),
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
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontsSizesManager.s14,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.greyColor),
            ),
            putHorizontalSpace(AppSpacing.sp_4),
            ReusableText(
              text: '\$${widget.product.discountPrice}',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontsSizesManager.s14,
                  color: AppColors.primaryColor),
            ),
          ],
        )
      ],
    );
  }
}
