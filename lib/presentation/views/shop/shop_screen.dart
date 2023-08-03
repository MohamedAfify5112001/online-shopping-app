import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/presentation/view_model/product/product_bloc.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import 'build_category.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.08),
                  spreadRadius: 6,
                  blurRadius: 24.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: buildAppBar(context),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return TabBarView(
              children: [
                ReusableBuildingCategory(
                  categoryItems: BannerCategory.womanBannersCategory,
                  personType: PersonType.woman,
                  newProduct: state.newProducts,
                  shoesProduct: state.shoesProducts,
                  accessoriesProduct: state.accessoriesProducts,
                ),
                ReusableBuildingCategory(
                  categoryItems: BannerCategory.manBannersCategory,
                  personType: PersonType.man,
                  newProduct: state.newProducts,
                  shoesProduct: state.shoesProducts,
                  accessoriesProduct: state.accessoriesProducts,
                ),
                ReusableBuildingCategory(
                  categoryItems: BannerCategory.kidsBannersCategory,
                  personType: PersonType.kids,
                  newProduct: state.newProducts,
                  shoesProduct: state.shoesProducts,
                  accessoriesProduct: state.accessoriesProducts,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: ReusableText(
        text: "Categories",
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18.sp),
      ),
      actions: [
        const Icon(
          Icons.search,
        ),
        putHorizontalSpace(AppSpacing.sp_12),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(44.0),
        child: TabBar(
          indicatorColor: AppColors.primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
          unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
          labelStyle: Theme.of(context).textTheme.titleLarge,
          labelColor: AppColors.blackColor,
          tabs: const [
            Tab(text: "Woman"),
            Tab(text: "Men"),
            Tab(text: "Kids"),
          ],
        ),
      ),
    );
  }
}

sealed class BannerCategory {
  BannerCategory._();

  static final List<BannersType> womanBannersCategory = [
    (title: "New", image: "assets/images/image 4.1.png"),
    (title: "Clothes", image: "assets/images/image 4.2.png"),
    (title: "Shoes", image: "assets/images/image 4.3.png"),
    (title: "Accessories", image: "assets/images/image 4.4.png"),
  ];
  static final List<BannersType> manBannersCategory = [
    (title: "New", image: "assets/images/man1.jpeg"),
    (title: "Clothes", image: "assets/images/man2.jpg"),
    (title: "Shoes", image: "assets/images/man3.jpg"),
    (title: "Accessories", image: "assets/images/man4.jpg"),
  ];
  static final List<BannersType> kidsBannersCategory = [
    (title: "New", image: "assets/images/kids2.jpg"),
    (title: "Clothes", image: "assets/images/kids1.jpg"),
    (title: "Shoes", image: "assets/images/kids3.jpg"),
    (title: "Accessories", image: "assets/images/kids4.jpg"),
  ];
}

typedef BannersType = ({String title, String image});
