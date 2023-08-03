import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/views/checkout/shipping_address_item.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/token/theme/spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../components/text_component.dart';
import 'add_shipping_address.dart';

class ShippingAddressItemsScreen extends StatefulWidget {
  const ShippingAddressItemsScreen({Key? key}) : super(key: key);

  @override
  State<ShippingAddressItemsScreen> createState() =>
      _ShippingAddressItemsScreenState();
}

class _ShippingAddressItemsScreenState
    extends State<ShippingAddressItemsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutBloc>(context)
        .add(const FetchShippingAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 43.0,
        height: 43.0,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            PageTransition(
              child: const AddShippingAddress(),
              type: PageTransitionType.rightToLeft,
              reverseDuration: const Duration(milliseconds: 1300),
              duration: const Duration(milliseconds: 1300),
            ),
          ),
          backgroundColor: AppColors.blackColor,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            size: 28.0,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sp_16, vertical: AppSpacing.sp_36),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, stateCheckout) {
            final shippingAddresses = stateCheckout.shippingAddresses;
            return shippingAddresses.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              ShippingAddressItemWidget(
                                  shippingAddressModel:
                                      shippingAddresses[index]),
                          separatorBuilder: (context, index) =>
                              putVerticalSpace(AppSpacing.sp_24),
                          itemCount: shippingAddresses.length,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: SizedBox(
                        width: 160.0,
                        child: Lottie.asset('assets/json/empty.json')),
                  );
          },
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
        text: 'Shipping Addresses',
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18),
      ),
    );
  }
}
