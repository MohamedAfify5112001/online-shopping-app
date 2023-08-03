import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:online_shopping/presentation/views/bag/bag_item.dart';
import 'package:online_shopping/presentation/views/components/btn_comp.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/extensions.dart';
import 'package:online_shopping/token/routing.dart';
import 'package:page_transition/page_transition.dart';

import '../../../model/order_model.dart';
import '../../../token/constants.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../../view_model/bag/bag_bloc.dart';
import '../checkout/checkout_screen.dart';
import '../components/empty_space.dart';
import '../components/local_images.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({Key? key}) : super(key: key);

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  PromoCodeModel? $PromoCode;

  final promoCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BagBloc>().add(FetchBagItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Icon(
            Icons.search,
          ),
          putHorizontalSpace(AppSpacing.sp_12),
        ],
      ),
      body: BlocBuilder<BagBloc, BagState>(
        builder: (context, bagState) {
          return bagState.carts.products.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.sp_14),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        putVerticalSpace(AppSpacing.sp_18),
                        ReusableText(
                          text: "Bag Screen",
                          textStyle: Theme.of(context).textTheme.displayLarge!,
                        ),
                        putVerticalSpace(AppSpacing.sp_24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            bagState.carts
                                .productQuantity(bagState.carts.products)
                                .keys
                                .length,
                            (index) => Container(
                              margin: const EdgeInsets.only(
                                  bottom: AppSpacing.sp_24),
                              child: BagProductItem(
                                bag: bagState.carts
                                    .productQuantity(bagState.carts.products)
                                    .keys
                                    .elementAt(index),
                                quantity: bagState.carts
                                    .productQuantity(bagState.carts.products)
                                    .values
                                    .elementAt(index),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => _buildPromoCodeLists());
                          },
                          child: _buildPromoCode(false),
                        ),
                        putVerticalSpace(AppSpacing.sp_28),
                        const TotalWidget(),
                        putVerticalSpace(AppSpacing.sp_24),
                        SizedBox(
                          width: double.infinity,
                          child: ReusableButton(
                            onPressed: () => $PromoCode == null
                                ? null
                                : Navigator.of(context).push(
                                    PageTransition(
                                      child: CheckOutScreen(
                                        cart: bagState.carts,
                                        $PromoCode: $PromoCode!,
                                      ),
                                      type: PageTransitionType.rightToLeft,
                                      reverseDuration:
                                          const Duration(milliseconds: 1500),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                    ),
                                  ),
                            text: 'CHECK OUT',
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: FontsSizesManager.s14,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : bagState.bagProductStatus == BagStatus.loading
                  ? Center(
                      child: SizedBox(
                          width: 160.0,
                          child: Lottie.asset(
                              'assets/json/animation_lkbb3fx0.json')),
                    )
                  : Center(
                      child: SizedBox(
                          width: 160.0,
                          child: Lottie.asset('assets/json/empty.json')),
                    );
        },
      ),
    );
  }

  Builder _buildPromoCode(bool isTextForm) {
    return Builder(
      builder: (context) => Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 343.0,
              height: 36.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.05),
                    // Shadow color
                    blurRadius: 8.0,
                    offset: const Offset(0, 1),
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: !isTextForm
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.sp_20,
                        top: AppSpacing.sp_7,
                      ),
                      child: $PromoCode == null
                          ? ReusableText(
                              text: 'Enter your promo code',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: FontsSizesManager.s14,
                                  ),
                            )
                          : ReusableText(
                              text: $PromoCode!.promoName,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: $PromoCode!.promoName.isNotEmpty
                                        ? AppColors.blackColor
                                        : AppColors.greyColor,
                                    fontSize: FontsSizesManager.s14,
                                  ),
                            ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sp_3),
                      child: TextFormField(
                        cursorColor: AppColors.primaryColor,
                        controller: promoCodeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintText: 'Enter your promo code',
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: FontsSizesManager.s14),
                        ),
                      ),
                    ),
            ),
            Positioned(
              right: -4,
              child: GestureDetector(
                onTap: () async => await Routing.goBack(context),
                child: Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                      color: AppColors.blackColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20.0,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeLists() => Builder(
        builder: (context) => Container(
          height: 464.0,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(34.0),
              topRight: Radius.circular(34.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sp_16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  putVerticalSpace(52.0),
                  Center(child: _buildPromoCode(true)),
                  putVerticalSpace(AppSpacing.sp_32),
                  ReusableText(
                    text: "Your Promo Codes",
                    textStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: FontsSizesManager.s18,
                            ),
                  ),
                  putVerticalSpace(AppSpacing.sp_18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: promoCodes
                        .map((promoCodes) => Container(
                            margin:
                                const EdgeInsets.only(bottom: AppSpacing.sp_24),
                            child: _buildPromoItem(context, promoCodes)))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Container _buildPromoItem(
      BuildContext context, PromoCodeModel promoCodeModel) {
    return Container(
      width: double.infinity,
      height: 80.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: AppColors.backgroundColor,
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
          promoCodeModel.image.isEmpty
              ? Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: promoCodeModel.color.toColor(),
                    gradient: promoCodeModel.isGradient
                        ? LinearGradient(
                            colors: [
                              promoCodeModel.color.toColor(),
                              promoCodeModel.isGradientColor
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : LinearGradient(
                            colors: [
                              promoCodeModel.color.toColor(),
                              promoCodeModel.color.toColor(),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Row(
                      children: [
                        ReusableText(
                          text: promoCodeModel.discountRate,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: AppColors.whiteColor, fontSize: 30.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: '%',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                            ReusableText(
                              text: 'off',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    LocalImage(
                      imagePath: promoCodeModel.image,
                      fit: BoxFit.cover,
                      width: 80.0,
                      height: 80.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: Row(
                        children: [
                          ReusableText(
                            text: promoCodeModel.discountRate,
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 30.0),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: '%',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              ReusableText(
                                text: 'off',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
          putHorizontalSpace(11.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: promoCodeModel.promoName,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: FontsSizesManager.s14),
                      ),
                      ReusableText(
                        text: promoCodeModel.promoDesc,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: FontsSizesManager.s11),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ReusableText(
                        text: promoCodeModel.time,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: FontsSizesManager.s11,
                                color: AppColors.greyColor),
                      ),
                      putVerticalSpace(AppSpacing.sp_10),
                      Container(
                        width: 93.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.25),
                              // Shadow color
                              spreadRadius: 0.0,
                              // Spread radius
                              blurRadius: 8.0,
                              // Blur radius
                              offset: const Offset(0, 4), // Offset
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() => $PromoCode = promoCodeModel);
                              setState(() => promoCodeController.text =
                                  $PromoCode!.promoName);
                            },
                            child: ReusableText(
                              text: 'Apply',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: FontsSizesManager.s14,
                                      color: AppColors.whiteColor),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BagBloc, BagState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableText(
              text: "Total amount:",
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.greyColor,
                    fontSize: FontsSizesManager.s14,
                  ),
            ),
            ReusableText(
              text: '${state.carts.subtotal.toStringAsFixed(2)}\$',
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: FontsSizesManager.s18,
                  ),
            ),
          ],
        );
      },
    );
  }
}
