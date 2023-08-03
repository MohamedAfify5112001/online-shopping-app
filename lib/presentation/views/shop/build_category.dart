import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/shop/category_items_screen.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/theme/font_sizes.dart';
import '../components/text_component.dart';

typedef BannersType = ({String title, String image});

class ReusableBuildingCategory extends StatelessWidget {
  final List<BannersType> categoryItems;
  final List<Product> newProduct;
  final List<Product> shoesProduct;
  final List<Product> accessoriesProduct;
  final PersonType personType;

  const ReusableBuildingCategory(
      {Key? key,
      required this.categoryItems,
      required this.personType,
      required this.newProduct,
      required this.shoesProduct,
      required this.accessoriesProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (personType == PersonType.woman) {
      final List<Product> newWomen = newProduct
          .where((element) => element.personType == personType)
          .toList();
      final List<Product> shoesWomen = shoesProduct
          .where((element) => element.personType == personType)
          .toList();
      final List<Product> accessoriesWomen = accessoriesProduct
          .where((element) => element.personType == personType)
          .toList();
      final Map<String, List<Product>> productOfEachCategoryWoman = {
        'New': newWomen,
        'Clothes': newWomen,
        'Shoes': shoesWomen,
        'Accessories': accessoriesWomen,
      };
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInLeftBig(
              duration: const Duration(
                milliseconds: 900,
              ),
              child: _buildSaleBanner(),
            ),
            putVerticalSpace(AppSpacing.sp_16),
            FadeInUpBig(
              duration: const Duration(
                milliseconds: 1200,
              ),
              child: Column(
                children: categoryItems
                    .map((bannerCategory) => buildCategoryBannerItems(
                        context, bannerCategory,
                        personType: personType,
                        products:
                            productOfEachCategoryWoman[bannerCategory.title]!))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    } else if (personType == PersonType.man) {
      final List<Product> newMen = newProduct
          .where((element) => element.personType == personType)
          .toList();
      final List<Product> shoesMen = shoesProduct
          .where((element) => element.personType == personType)
          .toList();
      final List<Product> accessoriesMen = accessoriesProduct
          .where((element) => element.personType == personType)
          .toList();
      final Map<String, List<Product>> productOfEachCategoryMan = {
        'New': newMen,
        'Clothes': newMen,
        'Shoes': shoesMen,
        'Accessories': accessoriesMen,
      };
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInLeftBig(
              duration: const Duration(
                milliseconds: 900,
              ),
              child: _buildSaleBanner(),
            ),
            putVerticalSpace(AppSpacing.sp_16),
            FadeInUpBig(
              duration: const Duration(
                milliseconds: 1200,
              ),
              child: Column(
                children: categoryItems
                    .map((bannerCategory) => buildCategoryBannerItems(
                        context, bannerCategory,
                        products:
                            productOfEachCategoryMan[bannerCategory.title]!,
                        personType: personType))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      final List<Product> newKids = newProduct
          .where((element) => element.personType == personType)
          .toList();
      final List<Product> shoesKids = shoesProduct
          .where((element) => element.personType == personType)
          .toList();
      final List<Product> accessoriesKids = accessoriesProduct
          .where((element) => element.personType == personType)
          .toList();
      final Map<String, List<Product>> productOfEachCategoryKids = {
        'New': newKids,
        'Clothes': newKids,
        'Shoes': shoesKids,
        'Accessories': accessoriesKids,
      };
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInLeftBig(
              duration: const Duration(
                milliseconds: 900,
              ),
              child: _buildSaleBanner(),
            ),
            putVerticalSpace(AppSpacing.sp_16),
            FadeInUpBig(
              duration: const Duration(
                milliseconds: 1200,
              ),
              child: Column(
                children: categoryItems
                    .map((bannerCategory) => buildCategoryBannerItems(
                        context, bannerCategory,
                        products:
                            productOfEachCategoryKids[bannerCategory.title]!,
                        personType: personType))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildCategoryBannerItems(
      BuildContext context, BannersType bannerCategoryItem,
      {required List<Product> products, PersonType? personType}) {
    final String title = bannerCategoryItem.title;
    final String image = bannerCategoryItem.image;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(PageTransition(
        child: CategoryItemsScreen(
            title: title, products: products, personType: personType!),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 800),
      )),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        width: double.infinity,
        height: 100.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.08),
              spreadRadius: 0.0,
              blurRadius: 25.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0),
                    child: ReusableText(
                      text: title,
                      textStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: FontsSizesManager.s18.sp,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LocalImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imagePath: image,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleBanner() {
    return Builder(
      builder: (context) => Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0.r),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.08),
              spreadRadius: 0.0,
              blurRadius: 25.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReusableText(
              text: "SUMMER SALES",
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: FontsSizesManager.s24.sp,
                  color: AppColors.whiteColor),
            ),
            ReusableText(
              text: "Up to 50% off",
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontsSizesManager.s14.sp,
                  color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
