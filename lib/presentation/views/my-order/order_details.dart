import 'package:flutter/material.dart';
import 'package:online_shopping/model/order_model.dart';
import 'package:online_shopping/presentation/views/my-order/product_item_of_order.dart';

import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/btn_comp.dart';
import '../components/empty_space.dart';
import '../components/local_images.dart';
import '../components/text_component.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sp_16, vertical: AppSpacing.sp_31),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Order ${order.orderNumber}",
                    textStyle: Theme.of(context).textTheme.titleLarge!,
                  ),
                  ReusableText(
                    text: order.date,
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor,
                            ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ReusableText(
                        text: "Tracking number:",
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: FontsSizesManager.s14,
                                  color: AppColors.greyColor,
                                ),
                      ),
                      putHorizontalSpace(AppSpacing.sp_10),
                      ReusableText(
                        text: order.trackingNumber,
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: FontsSizesManager.s14,
                                ),
                      ),
                    ],
                  ),
                  ReusableText(
                    text: "Delivered",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.successColor,
                            ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_16),
              ReusableText(
                text: "${order.cart.products.length} items",
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: FontsSizesManager.s14,
                    ),
              ),
              putVerticalSpace(AppSpacing.sp_18),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  order.cart.products.length,
                  (index) => Container(
                    margin: index != 2
                        ? const EdgeInsets.only(bottom: 24.0)
                        : const EdgeInsets.only(bottom: 34.0),
                    child: ProductItemForOrder(
                      product: order.cart.products[index],
                      quantity: order.cart.productQuantityAllProducts?[index],
                    ),
                  ),
                ),
              ),
              ReusableText(
                text: "Order information",
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: FontsSizesManager.s14,
                    ),
              ),
              putVerticalSpace(AppSpacing.sp_15),
              Row(
                children: [
                  ReusableText(
                    text: "Shipping Address:",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor,
                            ),
                  ),
                  putHorizontalSpace(AppSpacing.sp_10),
                  Expanded(
                    child: ReusableText(
                      text:
                          "${order.shippingAddress.address} ,${order.shippingAddress.city},${order.shippingAddress.state.substring(0, 2).toUpperCase()} 91709, ${order.shippingAddress.country}",
                      textStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: FontsSizesManager.s14,
                              ),
                    ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_24),
              Row(
                children: [
                  ReusableText(
                    text: "Payment method:",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor,
                            ),
                  ),
                  putHorizontalSpace(AppSpacing.sp_10),
                  order.paymentCard.isMasterOrVisa
                      ? const LocalImage(
                          imagePath: 'assets/images/mastercard.png',
                        )
                      : Container(
                          width: 64.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greyColor.withOpacity(0.08),
                                // Shadow color
                                spreadRadius: 0.0,
                                // Spread radius
                                blurRadius: 25.0,
                                // Blur radius
                                offset: const Offset(0, 1), // Offset
                              ),
                            ],
                          ),
                          child: const LocalImage(
                            imagePath: 'assets/images/visa.png',
                          ),
                        ),
                  putHorizontalSpace(AppSpacing.sp_10),
                  ReusableText(
                    text: "**** **** **** 3947",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                            ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_24),
              Row(
                children: [
                  ReusableText(
                    text: "Delivery method:",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor,
                            ),
                  ),
                  putHorizontalSpace(AppSpacing.sp_10),
                  ReusableText(
                    text:
                        "${order.deliveryMethod.methodDelivery}, ${order.deliveryMethod.date}, ${order.deliveryMethod.salary}\$",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                            ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_24),
              Row(
                children: [
                  ReusableText(
                    text: "Discount:",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor,
                            ),
                  ),
                  putHorizontalSpace(AppSpacing.sp_10),
                  ReusableText(
                    text: "${order.discountPromoCode.discountRate}%, ${order.discountPromoCode.promoDesc}",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                            ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_24),
              Row(
                children: [
                  ReusableText(
                    text: "Total Amount:",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor,
                            ),
                  ),
                  putHorizontalSpace(AppSpacing.sp_10),
                  ReusableText(
                    text:
                        "${(order.totalAmount - ((int.parse(order.discountPromoCode.discountRate) / 100).toDouble() * order.totalAmount)) + order.deliveryMethod.salary}\$",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                            ),
                  ),
                ],
              ),
              putVerticalSpace(AppSpacing.sp_35),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0)),
                      child: ReusableText(
                        text: 'Reorder',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: FontsSizesManager.s14,
                                ),
                      ),
                    ),
                  ),
                  putHorizontalSpace(AppSpacing.sp_24),
                  Flexible(
                    child: SizedBox(
                      child: ReusableButton(
                        isPadding: false,
                        onPressed: () {},
                        text: 'Leave feedback',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: FontsSizesManager.s14,
                                  color: AppColors.whiteColor,
                                ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
        onPressed: () => Routing.goBack(context),
      ),
      centerTitle: true,
      title: ReusableText(
        text: "Order Details",
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: FontsSizesManager.s18,
            ),
      ),
      actions: [
        const Icon(
          Icons.search,
        ),
        putHorizontalSpace(AppSpacing.sp_12),
      ],
    );
  }
}
