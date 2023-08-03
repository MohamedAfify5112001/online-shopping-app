import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/presentation/view_model/bag/bag_bloc.dart';
import 'package:online_shopping/token/theme/spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/app_colors.dart';
import '../../../token/theme/font_sizes.dart';
import '../../view_model/product/product_bloc.dart';
import '../components/empty_space.dart';
import '../components/remote_image.dart';
import '../components/text_component.dart';
import '../shop/product_details.dart';

class BagProductItem extends StatelessWidget {
  final Product bag;
  final int quantity;

  const BagProductItem({Key? key, required this.bag, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BagBloc, BagState>(
      builder: (context, state) {
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
                    child: ProductDetails(product: bag),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 800),
                    reverseDuration: const Duration(milliseconds: 800),
                  ),
                ),
                child: RemoteImage(
                  imagePath: bag.image,
                  fit: BoxFit.cover,
                  width: 104.0,
                  height: 104.0,
                ),
              ),
              putHorizontalSpace(11.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: [
                              bag.name.split(' ')[0],
                              bag.name.split(' ')[1]
                            ].join(' '),
                            textOverflow: TextOverflow.ellipsis,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: FontsSizesManager.s16),
                          ),
                          SizedBox(
                            height: 10,
                            child: PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, size: 20),
                              padding: EdgeInsets.zero,
                              offset: const Offset(-40, -20),
                              color: AppColors.greyColor,
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'addFav',
                                    child: Center(
                                      child: ReusableText(
                                        text: 'Add to favorites',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: FontsSizesManager.s11,
                                              color: AppColors.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Center(
                                      child: ReusableText(
                                        text: 'Delete from the list',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: FontsSizesManager.s11,
                                              color: AppColors.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              onSelected: (String value) {
                                if (value == 'addFav') {
                                  bag.isFavorite = true;
                                  context
                                      .read<ProductBloc>()
                                      .add(AddProductInFavEvent(bag));
                                } else if (value == 'delete') {
                                  context
                                      .read<BagBloc>()
                                      .add(DeleteItemFromBagList(bag));
                                }
                              },
                            ),
                          )
                        ],
                      ),
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
                                text: bag.color,
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
                                    text: bag.size,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontSize: FontsSizesManager.s11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      putVerticalSpace(14.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.greyColor
                                              .withOpacity(0.1),
                                          spreadRadius: 0,
                                          blurRadius: 8.0,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    width: 36.0,
                                    height: 36.0,
                                    child: Icon(
                                      Icons.add,
                                      size: 20.0,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  onTap: () {
                                    context.read<BagBloc>().add(
                                        AddItemInBagWithQuantityEvent(
                                            product: bag));
                                  }),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sp_16),
                                child: ReusableText(
                                  text: quantity.toString(),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14),
                                ),
                              ),
                              GestureDetector(
                                onTap: quantity == 1
                                    ? null
                                    : () {
                                        context.read<BagBloc>().add(
                                            RemoveItemInBagWithQuantityEvent(
                                                product: bag));
                                      },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyColor
                                            .withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 8.0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: 36.0,
                                  height: 36.0,
                                  child: Icon(
                                    Icons.remove,
                                    size: 20.0,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: ReusableText(
                              text: '${bag.discountPrice.toString()}\$',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: FontsSizesManager.s14),
                            ),
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
      },
    );
  }
}
