import 'package:flutter/material.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/presentation/views/shop/product_item_for_category.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';

import '../../../model/product_model.dart';
import '../../../token/routing.dart';
import '../../../token/theme/spacing.dart';
import '../components/empty_space.dart';
import '../components/products_in _lists.dart';
import 'build_product_item_horizontal.dart';

class CategoryItemsScreen extends StatefulWidget {
  final String title;
  final List<Product> products;
  final PersonType personType;

  const CategoryItemsScreen(
      {Key? key,
      required this.title,
      required this.products,
      required this.personType})
      : super(key: key);

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  bool _isGrid = true;
  List<String> brands = ['Adidas', 'Boutique Moschino', 'Blend'];
  List<String> sorts = ['Price: lowest to high', 'Price: highest to low'];
  late List<Product> products = widget.products;
  late List<Product> filterProducts = products;

  int _currentIndexForFilter = -1;
  int _currentIndexForSorting = 0;
  String brandName = '';
  String sortOption = 'Price: lowest to high';

  @override
  void initState() {
    super.initState();
    filterProducts
        .sort((p1, p2) => p1.discountPrice.compareTo(p2.discountPrice));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        actions: [
          const Icon(
            Icons.search,
          ),
          putHorizontalSpace(AppSpacing.sp_12),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
          onPressed: () => Routing.goBack(context),
        ),
        title: ReusableText(
          text: "${widget.personType.name}'s ${widget.title}",
          textStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: FontsSizesManager.s18),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            putVerticalSpace(AppSpacing.sp_8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.12),
                    spreadRadius: 0,
                    blurRadius: 12.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    buildChipCategoryFilterAndSorting(),
                    putVerticalSpace(AppSpacing.sp_18),
                    buildFilterAndSorting()
                  ],
                ),
              ),
            ),
            putVerticalSpace(AppSpacing.sp_16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: _isGrid
                  ? BuildingGridViewItemsCategory(
                      products: filterProducts,
                    )
                  : BuildingListViewItemsCategory(products: filterProducts),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFilterAndSorting() => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            color: AppColors.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 352.0,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(34.0),
                                  topRight: Radius.circular(34.0))),
                          child: buildingItemsBottomSheetModalForFilters(),
                        );
                      },
                    ).then((value) {
                      setState(() => brandName = value);
                      setState(() => filterProducts = products
                          .where((element) =>
                              element.brand.toLowerCase() ==
                              brandName.toLowerCase())
                          .toList());
                    });
                  },
                  child: Row(
                    children: [
                      const LocalImage(
                          imagePath: 'assets/images/filter.png', width: 24.0),
                      putHorizontalSpace(AppSpacing.sp_7),
                      ReusableText(
                        text: _currentIndexForFilter != -1
                            ? brandName
                            : 'Filters',
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: FontsSizesManager.s11),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 352.0,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(34.0),
                                  topRight: Radius.circular(34.0))),
                          child: buildingItemsBottomSheetModalForSorting(),
                        );
                      },
                    ).then((value) {
                      setState(() => sortOption = value);
                      if (sortOption == 'Price: highest to low') {
                        setState(() =>
                            filterProducts = filterProducts.reversed.toList());
                      } else {
                        setState(() => filterProducts = products);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      const LocalImage(
                          imagePath: 'assets/images/swap.png', width: 24.0),
                      putHorizontalSpace(AppSpacing.sp_7),
                      ReusableText(
                        text: sortOption,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: FontsSizesManager.s11),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _isGrid = !_isGrid),
                  child: !_isGrid
                      ? const LocalImage(
                          imagePath: 'assets/images/view_module.png',
                          width: 24.0,
                        )
                      : const LocalImage(
                          imagePath: 'assets/images/view_list.png',
                          width: 24.0,
                        ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildingItemsBottomSheetModalForFilters() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sp_36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ReusableText(
                text: 'Filter By',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18.0)),
          ),
          putVerticalSpace(AppSpacing.sp_33),
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateForFilter) =>
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  3,
                  (index) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sp_17),
                      child: InkWell(
                        onTap: () async {
                          setStateForFilter(
                              () => _currentIndexForFilter = index);
                          await Routing.goBack(
                              context, brands[_currentIndexForFilter]);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _currentIndexForFilter == index
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.sp_16),
                            child: ReusableText(
                              text: brands[index],
                              textStyle: _currentIndexForFilter == index
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.whiteColor,
                                      )
                                  : Theme.of(context).textTheme.titleSmall!,
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildingItemsBottomSheetModalForSorting() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sp_36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ReusableText(
                text: 'Sort By',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 18.0)),
          ),
          putVerticalSpace(AppSpacing.sp_33),
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateForFilter) =>
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  2,
                  (index) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sp_17),
                      child: InkWell(
                        onTap: () async {
                          setStateForFilter(
                              () => _currentIndexForSorting = index);
                          await Routing.goBack(
                              context, sorts[_currentIndexForSorting]);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _currentIndexForSorting == index
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.sp_16),
                            child: ReusableText(
                              text: sorts[index],
                              textStyle: _currentIndexForSorting == index
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.whiteColor,
                                      )
                                  : Theme.of(context).textTheme.titleSmall!,
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChipCategoryFilterAndSorting() {
    return Builder(
      builder: (context) => SizedBox(
        height: 43.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SizedBox(
                    height: 30.0,
                    child: Chip(
                        backgroundColor: AppColors.blackColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(29.0))),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: ReusableText(
                            text: _chipsTitle[index],
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        )),
                  ),
              separatorBuilder: (context, index) =>
                  putHorizontalSpace(AppSpacing.sp_7),
              itemCount: _chipsTitle.length),
        ),
      ),
    );
  }
}

final List<String> _chipsTitle = [
  'T-Shirt',
  'Hoodies',
  'Crop Tops',
  'Blouses',
  'Sleeveless',
  'Blazers',
  'Jeans'
];
