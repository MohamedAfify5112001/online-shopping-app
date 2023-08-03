import 'package:flutter/material.dart';
import 'package:online_shopping/model/shipping_address_model.dart';
import 'package:online_shopping/presentation/views/checkout/shipping_address_items_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/empty_space.dart';
import '../components/text_component.dart';

class ShippingAddressItemWidget extends StatefulWidget {
  final ShippingAddressModel shippingAddressModel;

  const ShippingAddressItemWidget({
    super.key,
    required this.shippingAddressModel,
  });

  @override
  State<ShippingAddressItemWidget> createState() =>
      _ShippingAddressItemWidgetState();
}

class _ShippingAddressItemWidgetState extends State<ShippingAddressItemWidget> {
  bool isShipping = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isShipping = true);
        Routing.goBack(
          context,
          widget.shippingAddressModel,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.08), // Shadow color
              spreadRadius: 0.0, // Spread radius
              blurRadius: 25.0, // Blur radius
              offset: const Offset(0, 1), // Offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sp_28, vertical: AppSpacing.sp_6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: widget.shippingAddressModel.fullName,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: FontsSizesManager.s14),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: ReusableText(
                      text: 'Edit',
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
                text: widget.shippingAddressModel.address,
                textStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
              ReusableText(
                text:
                    '${widget.shippingAddressModel.city}, ${widget.shippingAddressModel.state.substring(0, 2).toUpperCase()} ${widget.shippingAddressModel.zipCode}, ${widget.shippingAddressModel.country}',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
              putVerticalSpace(AppSpacing.sp_7),
              Row(
                children: [
                  Checkbox(
                    value: isShipping,
                    visualDensity: VisualDensity.compact,
                    onChanged: (value) {},
                    activeColor: AppColors.blackColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  ReusableText(
                      text: 'Use as the shipping address',
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: FontsSizesManager.s14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
