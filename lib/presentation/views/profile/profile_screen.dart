import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/data/cache/cache_helper.dart';

import 'package:online_shopping/presentation/view_model/auth/authentication_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/routing.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';

import '../../../token/theme/spacing.dart';
import '../components/empty_space.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(const FetchUserEvent());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sp_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            putVerticalSpace(AppSpacing.sp_18),
            ReusableText(
              text: "My profile",
              textStyle: Theme.of(context).textTheme.displayLarge!,
            ),
            putVerticalSpace(AppSpacing.sp_24),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, stateListenUser) {
                if (stateListenUser is GetUserSuccessState) {}
              },
              builder: (context, stateUser) {
                return stateUser is GetUserSuccessState
                    ? Row(
                        children: [
                          SizedBox(
                            width: 64.0,
                            height: 64.0,
                            child: CircleAvatar(
                              backgroundColor: AppColors.greyColor,
                              foregroundColor: AppColors.greyColor,
                              backgroundImage: NetworkImage(
                                stateUser.user.image,
                              ),
                            ),
                          ),
                          putHorizontalSpace(AppSpacing.sp_10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: stateUser.user.name,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: FontsSizesManager.s18,
                                    ),
                              ),
                              ReusableText(
                                text: stateUser.user.email,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.greyColor,
                                      fontSize: FontsSizesManager.s14,
                                    ),
                              ),
                            ],
                          )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
              },
            ),
            putVerticalSpace(AppSpacing.sp_28),
            InkWell(
              onTap: () async => Routing.navigateTo(
                context,
                Routing.myOrder,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: 'My orders',
                          textStyle: Theme.of(context).textTheme.titleLarge!),
                      ReusableText(
                        text:
                            'Already have ${CacheHelper.getValue(key: 'order')} orders',
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: FontsSizesManager.s11,
                                ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16.0,
                    color: AppColors.greyColor,
                  )
                ],
              ),
            ),
            putVerticalSpace(AppSpacing.sp_28),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, stateCheckout) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async => Routing.navigateTo(
                        context,
                        Routing.shipping,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: 'Shipping addresses',
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge!),
                              ReusableText(
                                text:
                                    '${CacheHelper.getValue(key: 'shipping')} addresses',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.greyColor,
                                      fontSize: FontsSizesManager.s11,
                                    ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16.0,
                            color: AppColors.greyColor,
                          )
                        ],
                      ),
                    ),
                    putVerticalSpace(AppSpacing.sp_28),
                    InkWell(
                      onTap: () async => Routing.navigateTo(
                        context,
                        Routing.payment,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: 'Payment methods',
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge!),
                              ReusableText(
                                text: 'Visa  **34',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.greyColor,
                                      fontSize: FontsSizesManager.s11,
                                    ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16.0,
                            color: AppColors.greyColor,
                          )
                        ],
                      ),
                    ),
                    putVerticalSpace(AppSpacing.sp_28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: 'Promocodes',
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge!),
                            ReusableText(
                              text: 'You have special promocodes',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: FontsSizesManager.s11,
                                  ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16.0,
                          color: AppColors.greyColor,
                        )
                      ],
                    ),
                    putVerticalSpace(AppSpacing.sp_28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: 'My reviews',
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge!),
                            ReusableText(
                              text: 'Reviews for 4 items',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: FontsSizesManager.s11,
                                  ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16.0,
                          color: AppColors.greyColor,
                        )
                      ],
                    ),
                    putVerticalSpace(AppSpacing.sp_28),
                    InkWell(
                      onTap: () async {
                        await Future.wait([
                          CacheHelper.removeValue(key: 'uId'),
                          Routing.removeWith(context, Routing.signUpRoute),
                        ]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: 'Logout',
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge!),
                              ReusableText(
                                text: 'Logout From Your Account',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.greyColor,
                                      fontSize: FontsSizesManager.s11,
                                    ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16.0,
                            color: AppColors.greyColor,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
