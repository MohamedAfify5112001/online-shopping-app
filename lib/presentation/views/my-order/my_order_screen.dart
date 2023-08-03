import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:page_transition/page_transition.dart';

import '../../../model/order_model.dart';
import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/spacing.dart';
import '../components/text_component.dart';
import 'order_details.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutBloc>(context).add(const FetchOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
          onPressed: () => Routing.goBack(context),
        ),
        actions: [
          const Icon(
            Icons.search,
          ),
          putHorizontalSpace(AppSpacing.sp_12),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sp_16, vertical: AppSpacing.sp_18),
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, stateOrders) {
              final List<OrderModel> orders = stateOrders.orders;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "My Orders",
                    textStyle: Theme.of(context).textTheme.displayLarge!,
                  ),
                  putVerticalSpace(AppSpacing.sp_30),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        OrderWidget(order: orders[index], index: index),
                    separatorBuilder: (context, index) =>
                        putVerticalSpace(AppSpacing.sp_24),
                    itemCount: orders.length,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  final int index;

  const OrderWidget({
    super.key,
    required this.order,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.12),
            // Shadow color
            spreadRadius: 0.0,
            // Spread radius
            blurRadius: 24.0,
            // Blur radius
            offset: const Offset(0, 1), // Offset
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sp_18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  text: order.orderNumber,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                ReusableText(
                  text: order.date,
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: FontsSizesManager.s14,
                        color: AppColors.greyColor,
                      ),
                ),
              ],
            ),
            putVerticalSpace(AppSpacing.sp_15),
            Row(
              children: [
                ReusableText(
                  text: "Tracking number:",
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: FontsSizesManager.s14,
                        color: AppColors.greyColor,
                      ),
                ),
                putHorizontalSpace(AppSpacing.sp_10),
                ReusableText(
                  text: order.trackingNumber,
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: FontsSizesManager.s14,
                      ),
                ),
              ],
            ),
            putVerticalSpace(AppSpacing.sp_4),
            QuantityAndTotalWidget(order: order),
            putVerticalSpace(AppSpacing.sp_14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 98.0,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).push(
                      PageTransition(
                        child:  OrderDetails(order:order),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 800),
                        reverseDuration: const Duration(milliseconds: 800),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.0)),
                    child: ReusableText(
                      text: 'Details',
                      textStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: FontsSizesManager.s14,
                              ),
                    ),
                  ),
                ),
                ReusableText(
                  text: "Delivered",
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: FontsSizesManager.s14,
                        color: AppColors.successColor,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class QuantityAndTotalWidget extends StatelessWidget {
  final OrderModel order;

  const QuantityAndTotalWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ReusableText(
              text: "Quantity:",
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: FontsSizesManager.s14,
                    color: AppColors.greyColor,
                  ),
            ),
            putHorizontalSpace(AppSpacing.sp_10),
            ReusableText(
              text: order.cart.products.length.toString(),
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: FontsSizesManager.s14,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            ReusableText(
              text: "Total Amount:",
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: FontsSizesManager.s14,
                    color: AppColors.greyColor,
                  ),
            ),
            putHorizontalSpace(AppSpacing.sp_10),
            ReusableText(
              text:
                  "${(order.totalAmount - ((int.parse(order.discountPromoCode.discountRate) / 100).toDouble() * order.totalAmount)) + order.deliveryMethod.salary}\$",
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: FontsSizesManager.s14,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
