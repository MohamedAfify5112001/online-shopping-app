import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/presentation/view_model/home/banner/banner_bloc.dart';
import 'package:online_shopping/presentation/view_model/product/product_bloc.dart';
import 'package:online_shopping/presentation/views/components/banner_slider.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/home/banner_items.dart';
import 'package:online_shopping/presentation/views/components/product_items.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import '../../../model/product_model.dart';
import '../../../token/app_colors.dart';
import '../components/text_component.dart';
import '../components/toast_comp.dart';
import 'collections_banners.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<BannerBloc, BannerState>(
                listener: (context, bannerState) {
                  if (bannerState.status == BannerStatus.failure) {
                    getToastMessage(
                        msg: "Error Fetched Banners",
                        toastMessage: ToastMessage.errorToast);
                  }
                },
                builder: (context, bannerState) {
                  return BannerSlider(
                    items: bannerState.banners
                        .map((banner) => BannerItem(
                              url: banner.imageUrl,
                              title: banner.title,
                            ))
                        .toList(),
                  );
                },
              ),
              putVerticalSpace(AppSpacing.sp_37),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, productState) {
                  if (productState.newProductStatus == ProductStatus.failure) {
                    getToastMessage(
                        msg: "Error Fetched Banners",
                        toastMessage: ToastMessage.errorToast);
                  }
                },
                builder: (context, state) {
                  List<Product> products = state.newProducts
                      .where((element) => element.color != 'black')
                      .toList();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSaleDesc(context),
                        putVerticalSpace(AppSpacing.sp_22),
                        ReusableProductItems(
                          height: 283.0.h,
                          scrollDirection: Axis.horizontal,
                          products: products,
                          width: 150.0,
                        ),
                        putVerticalSpace(AppSpacing.sp_40),
                        buildNewDesc(context),
                        putVerticalSpace(AppSpacing.sp_22),
                        ReusableProductItems(
                          width: 150.0,
                          height: 283.0.h,
                          scrollDirection: Axis.horizontal,
                          products: state.newProducts,
                        ),
                      ],
                    ),
                  );
                },
              ),
              putVerticalSpace(AppSpacing.sp_5),
              const CollectionBanners(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSaleDesc(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSaleItems(),
        ReusableText(
          text: 'View all',
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: FontsSizesManager.s11),
        ),
      ],
    );
  }

  Row buildNewDesc(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildNewItems(),
        ReusableText(
          text: 'View all',
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: FontsSizesManager.s11),
        ),
      ],
    );
  }

  Builder buildSaleItems() => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
              text: 'Sale',
              textStyle: Theme.of(context).textTheme.displayLarge!,
            ),
            putVerticalSpace(AppSpacing.sp_4),
            ReusableText(
              text: 'Super summer sale',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.greyColor, fontSize: FontsSizesManager.s11),
            ),
          ],
        ),
      );

  Builder buildNewItems() => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
              text: 'New',
              textStyle: Theme.of(context).textTheme.displayLarge!,
            ),
            putVerticalSpace(AppSpacing.sp_4),
            ReusableText(
              text: 'You’ve never seen it before!',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.greyColor, fontSize: FontsSizesManager.s11),
            ),
          ],
        ),
      );
}
