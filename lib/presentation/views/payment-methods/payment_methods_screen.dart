import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/views/checkout/payment_cards.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:page_transition/page_transition.dart';

import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../checkout/add_card.dart';
import '../components/empty_space.dart';
import '../components/text_component.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutBloc>(context).add(const FetchCardsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: SizedBox(
        width: 43.0,
        height: 43.0,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            PageTransition(
              child: const AddingNewCardWidget(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sp_16),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, stateCheckout) {
            final cards = stateCheckout.cards;
            return stateCheckout.cardsStatus == CheckoutStatus.loading
                ? Center(
                    child: SizedBox(
                        width: 160.0,
                        child: Lottie.asset(
                            'assets/json/animation_lkbb3fx0.json')),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        putVerticalSpace(AppSpacing.sp_31),
                        ReusableText(
                          text: 'Your payment cards',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: FontsSizesManager.s16),
                        ),
                        putVerticalSpace(AppSpacing.sp_29),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                cards[index].isMasterCardOrVisa
                                    ? MasterPaymentCardWidget(
                                        cardModel: cards[index])
                                    : VisaPaymentCardWidget(
                                        cardModel: cards[index]),
                            separatorBuilder: (context, index) =>
                                putVerticalSpace(AppSpacing.sp_39),
                            itemCount: cards.length),
                      ],
                    ),
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
        text: 'Payment methods',
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18),
      ),
    );
  }
}
