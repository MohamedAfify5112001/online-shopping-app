import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/views/checkout/shipping_address_items_screen.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/presentation/views/components/toast_comp.dart';
import 'package:online_shopping/presentation/views/payment-methods/payment_methods_screen.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/extensions.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';
import 'package:online_shopping/token/theme/spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../../../model/cart.dart';
import '../../../model/order_model.dart';
import '../../../model/shipping_address_model.dart';
import '../../../token/constants.dart';
import '../../../token/routing.dart';
import '../components/btn_comp.dart';
import 'delivery_methods.dart';

class CheckOutScreen extends StatefulWidget {
  final Cart cart;
  final PromoCodeModel $PromoCode;

  const CheckOutScreen({
    Key? key,
    required this.cart,
    required this.$PromoCode,
  }) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  PaymentCard? paymentCard;
  DeliveryMethods? deliveryMethods;
  ShippingAddressModel? shippingAddressModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) async {
        if (state.addNewOrderStatus == CheckoutStatus.success) {
          await Future.wait([
            getToastMessage(
                msg: 'Order is added successfully..',
                toastMessage: ToastMessage.successToast),
            Routing.removeWith(context, Routing.success)
          ]);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sp_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                putVerticalSpace(AppSpacing.sp_31),
                ReusableText(
                  text: 'Shipping address',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: FontsSizesManager.s16),
                ),
                putVerticalSpace(AppSpacing.sp_21),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sp_28,
                        vertical: AppSpacing.sp_6),
                    child: shippingAddressModel == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                text: 'No Shipping Address is Chosen',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: FontsSizesManager.s14),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .push(
                                  PageTransition(
                                    child: const ShippingAddressItemsScreen(),
                                    type: PageTransitionType.rightToLeft,
                                    reverseDuration:
                                        const Duration(milliseconds: 1300),
                                    duration:
                                        const Duration(milliseconds: 1300),
                                  ),
                                )
                                    .then((value) {
                                  setState(() => shippingAddressModel =
                                      (value as ShippingAddressModel));
                                }),
                                child: ReusableText(
                                  text: 'Add',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14,
                                          color: AppColors.primaryColor),
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                    text: shippingAddressModel!.fullName,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: FontsSizesManager.s14),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .push(
                                      PageTransition(
                                        child:
                                            const ShippingAddressItemsScreen(),
                                        type: PageTransitionType.rightToLeft,
                                        reverseDuration:
                                            const Duration(milliseconds: 1300),
                                        duration:
                                            const Duration(milliseconds: 1300),
                                      ),
                                    )
                                        .then((value) {
                                      setState(() => shippingAddressModel =
                                          (value as ShippingAddressModel));
                                    }),
                                    child: ReusableText(
                                      text: 'Change',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: FontsSizesManager.s14,
                                              color: AppColors.primaryColor),
                                    ),
                                  )
                                ],
                              ),
                              putVerticalSpace(AppSpacing.sp_7),
                              ReusableText(
                                text: shippingAddressModel!.address,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: FontsSizesManager.s14),
                              ),
                              ReusableText(
                                text:
                                    '${shippingAddressModel!.city}, ${shippingAddressModel!.state.substring(0, 2).toUpperCase()} ${shippingAddressModel!.zipCode}, ${shippingAddressModel!.country}',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: FontsSizesManager.s14),
                              ),
                              putVerticalSpace(AppSpacing.sp_7)
                            ],
                          ),
                  ),
                ),
                putVerticalSpace(AppSpacing.sp_56),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Payment',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          PageTransition(
                            child: const PaymentMethodsScreen(),
                            type: PageTransitionType.rightToLeft,
                            reverseDuration: const Duration(milliseconds: 1300),
                            duration: const Duration(milliseconds: 1300),
                          ),
                        )
                            .then(
                          (value) {
                            setState(
                                () => paymentCard = (value as PaymentCard));
                          },
                        );
                      },
                      child: ReusableText(
                        text: 'Change',
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: FontsSizesManager.s14,
                                color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
                putVerticalSpace(AppSpacing.sp_17),
                paymentCard != null
                    ? Row(
                        children: [
                          Container(
                            width: 64.0,
                            height: 38.0,
                            decoration: BoxDecoration(
                              color: paymentCard!.isMasterOrVisa
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
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
                            child: paymentCard!.isMasterOrVisa
                                ? const LocalImage(
                                    imagePath: 'assets/images/mastercard.png',
                                  )
                                : const LocalImage(
                                    imagePath: 'assets/images/visa.png',
                                  ),
                          ),
                          putHorizontalSpace(AppSpacing.sp_17),
                          ReusableText(
                            text: paymentCard!.cardNumber.maskCardNumber,
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: FontsSizesManager.s14,
                                ),
                          ),
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sp_16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                text: 'No Payment Card is Chosen',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: FontsSizesManager.s14),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .push(
                                  PageTransition(
                                    child: const PaymentMethodsScreen(),
                                    type: PageTransitionType.rightToLeft,
                                    reverseDuration:
                                        const Duration(milliseconds: 1300),
                                    duration:
                                        const Duration(milliseconds: 1300),
                                  ),
                                )
                                    .then((value) {
                                  setState(() =>
                                      paymentCard = (value as PaymentCard));
                                }),
                                child: ReusableText(
                                  text: 'Add',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontSize: FontsSizesManager.s14,
                                          color: AppColors.primaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                putVerticalSpace(AppSpacing.sp_51),
                ReusableText(
                  text: 'Delivery method',
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: FontsSizesManager.s16),
                ),
                putVerticalSpace(AppSpacing.sp_21),
                Row(
                  children: List.generate(
                      allDeliveryMethods.length,
                      (index) => Expanded(
                              child: Padding(
                            padding: index == allDeliveryMethods.length - 1
                                ? EdgeInsets.zero
                                : const EdgeInsets.only(
                                    right: AppSpacing.sp_22),
                            child: GestureDetector(
                              onTap: () {
                                setState(() => deliveryMethods =
                                    allDeliveryMethods[index]);
                              },
                              child: DeliveryMethodWidget(
                                deliveryMethods: allDeliveryMethods[index],
                              ),
                            ),
                          ))),
                ),
                putVerticalSpace(AppSpacing.sp_51),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Order:',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor),
                    ),
                    ReusableText(
                      text: '${widget.cart.subtotal.toInt()}\$',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s16),
                    ),
                  ],
                ),
                putVerticalSpace(AppSpacing.sp_14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Delivery:',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor),
                    ),
                    ReusableText(
                      text: deliveryMethods != null
                          ? "${deliveryMethods?.salary}\$"
                          : "0\$",
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s16),
                    ),
                  ],
                ),
                putVerticalSpace(AppSpacing.sp_14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Summary:',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.greyColor),
                    ),
                    ReusableText(
                      text: deliveryMethods != null
                          ? '${widget.cart.subtotal.toInt() + deliveryMethods!.salary}\$'
                          : "0\$",
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: FontsSizesManager.s16),
                    ),
                  ],
                ),
                putVerticalSpace(AppSpacing.sp_22),
                SizedBox(
                  width: double.infinity,
                  child: ReusableButton(
                    onPressed: () async => context.read<CheckoutBloc>().add(
                          AddNewOrder(
                            orderModel: OrderModel(
                              orderNumber: orderAndTrackingNumbers,
                              trackingNumber: orderAndTrackingNumbers,
                              cart: widget.cart,
                              date: formatDate(DateTime.now()),
                              deliveryMethod: deliveryMethods!,
                              paymentCard: paymentCard!,
                              shippingAddress: shippingAddressModel!,
                              discountPromoCode: widget.$PromoCode,
                              totalAmount: widget.cart.subtotal.toInt(),
                            ),
                          ),
                        ),
                    text: 'SUBMIT ORDER',
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s14,
                              color: AppColors.whiteColor,
                            ),
                  ),
                ),
              ],
            ),
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
        text: 'Checkout',
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18),
      ),
    );
  }
}
