import 'package:flutter/material.dart';

import '../../../model/product_model.dart';
import '../../../token/theme/spacing.dart';
import '../shop/build_product_item_horizontal.dart';
import '../shop/product_item_for_category.dart';
import 'empty_space.dart';

class BuildingGridViewItemsCategory extends StatelessWidget {
  final List<Product> products;

  const BuildingGridViewItemsCategory({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 26.0,
            childAspectRatio: 0.63,
            crossAxisSpacing: AppSpacing.sp_17,
          ),
          itemBuilder: (context, index) => SizedBox(
              child: ProductItemForCategory(product: products[index]))),
    );
  }
}

class BuildingListViewItemsCategory extends StatelessWidget {
  final List<Product> products;

  const BuildingListViewItemsCategory({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              HorizontalProductItem(product: products[index]),
          separatorBuilder: (context, index) => putVerticalSpace(26.0),
          itemCount: products.length),
    );
  }
}
