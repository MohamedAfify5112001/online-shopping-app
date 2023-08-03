import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/model/product_model.dart';
import 'package:online_shopping/presentation/view_model/bag/bag_bloc.dart';
import 'package:online_shopping/presentation/views/components/btn_comp.dart';
import 'package:online_shopping/presentation/views/components/remote_image.dart';
import 'package:online_shopping/presentation/views/components/toast_comp.dart';
import 'package:online_shopping/presentation/views/review/review_screen.dart';
import 'package:online_shopping/token/app_colors.dart';

import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../../view_model/product/product_bloc.dart';
import '../components/empty_space.dart';
import '../components/product_items.dart';
import '../components/rating_bars.dart';
import '../components/text_component.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String _selectedOption = 'XXL';
  String _selectedOptionColor = 'black';
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        List<Product> canLikeThisItems = [
          ...state.newProducts,
          ...state.shoesProducts
        ];
        canLikeThisItems
            .removeWhere((element) => element.name == widget.product.name);
        canLikeThisItems.shuffle();
        return BlocListener<BagBloc, BagState>(
          listener: (context, bagState) {
            if (bagState.addBagProductStatus == BagStatus.success) {
              getToastMessage(
                  msg: 'Product is added successfully in bag',
                  toastMessage: ToastMessage.successToast);
            }
          },
          child: Scaffold(
            appBar: buildPreferredSizeForAppBar(context),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 413.0,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => RemoteImage(
                              imagePath: widget.product.images[index],
                              width: 275.0,
                              height: 413.0,
                              fit: BoxFit.cover,
                            ),
                        separatorBuilder: (context, index) =>
                            putHorizontalSpace(AppSpacing.sp_4),
                        itemCount: widget.product.images.length),
                  ),
                  putVerticalSpace(AppSpacing.sp_12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sp_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDropMenuProduct(context),
                        putVerticalSpace(AppSpacing.sp_22),
                        buildNameAndPriceProduct(context),
                        putVerticalSpace(AppSpacing.sp_8),
                        Row(
                          children: [
                            ReusableRatingBar(
                                initialRating: widget.product.rate),
                            putHorizontalSpace(AppSpacing.sp_2),
                            ReusableText(
                              text: '(${widget.product.rate})',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: FontsSizesManager.s8,
                                      color: AppColors.greyColor),
                            ),
                          ],
                        ),
                        putVerticalSpace(AppSpacing.sp_16),
                        ReusableText(
                          text:
                              '''${widget.product.name} It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text.''',
                          textStyle:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: FontsSizesManager.s14,
                                  ),
                        ),
                        putVerticalSpace(AppSpacing.sp_48),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ReusableButton(
                              text: 'ADD TO CART',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 14.0,
                                      color: AppColors.whiteColor),
                              onPressed: () {
                                BlocProvider.of<BagBloc>(context).add(
                                    AddItemInBagEvent(product: widget.product));
                              },
                            ),
                          ),
                        ),
                        putVerticalSpace(AppSpacing.sp_28),
                        Divider(
                          thickness: 0.3,
                          color: AppColors.greyColor,
                        ),
                        putVerticalSpace(AppSpacing.sp_16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                                text: 'Shipping info',
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium!),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 16.0,
                            )
                          ],
                        ),
                        putVerticalSpace(AppSpacing.sp_16),
                        Divider(
                          thickness: 0.3,
                          color: AppColors.greyColor,
                        ),
                        putVerticalSpace(AppSpacing.sp_16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                                text: 'Support',
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium!),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 16.0,
                            )
                          ],
                        ),
                        putVerticalSpace(AppSpacing.sp_16),
                        Divider(
                          thickness: 0.3,
                          color: AppColors.greyColor,
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                        product: widget.product,
                                      ))),
                          child: Column(
                            children: [
                              putVerticalSpace(AppSpacing.sp_16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                      text: 'Show Review',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16.0,
                                  )
                                ],
                              ),
                              putVerticalSpace(AppSpacing.sp_16),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.3,
                          color: AppColors.greyColor,
                        ),
                        putVerticalSpace(AppSpacing.sp_24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                                text: 'You can also like this',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: FontsSizesManager.s18)),
                            ReusableText(
                                text:
                                    '${canLikeThisItems.length.toString()} items',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: FontsSizesManager.s11,
                                        color: AppColors.greyColor)),
                          ],
                        ),
                        putVerticalSpace(AppSpacing.sp_12),
                        ReusableProductItems(
                          scrollDirection: Axis.horizontal,
                          products: canLikeThisItems,
                          height: 283.0.h,
                          width: 150.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildDropMenuProduct(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildSizeDropMenu(context)),
        putHorizontalSpace(AppSpacing.sp_16),
        Expanded(child: buildColorDropMenu(context)),
        putHorizontalSpace(AppSpacing.sp_16),
        GestureDetector(
          onTap: () async {
            setState(() {
              isFav = !isFav;
            });
            setState(() {
              widget.product.isFavorite = isFav;
            });
            if (widget.product.isFavorite) {
              context
                  .read<ProductBloc>()
                  .add(AddProductInFavEvent(widget.product));
            } else {
              context
                  .read<ProductBloc>()
                  .add(DeleteProductInFavEvent(widget.product));
            }
          },
          child: Container(
            width: 36.0.w,
            height: 36.0.h,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.08),
                    // Shadow color
                    spreadRadius: 0.0,
                    // Spread radius
                    blurRadius: 4.0,
                    // Blur radius
                    offset: Offset(0.w, 4.h), // Offset
                  ),
                ]),
            child: Center(
              child: widget.product.isFavorite
                  ? Icon(
                      Icons.favorite,
                      color: AppColors.primaryColor,
                      size: 18.0,
                    )
                  : Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color:
                          isFav ? AppColors.primaryColor : AppColors.greyColor,
                      size: 18.0,
                    ),
            ),
          ),
        )
      ],
    );
  }

  Row buildNameAndPriceProduct(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  '${widget.product.name.split(' ')[0]} ${widget.product.name.split(' ')[1]}',
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: FontsSizesManager.s24,
                      overflow: TextOverflow.ellipsis),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 4,
              pause: const Duration(milliseconds: 200),
              displayFullTextOnTap: true,
              isRepeatingAnimation: true,
              stopPauseOnTap: true,
            ),
            ReusableText(
              text: '${widget.product.name} ${widget.product.color} color',
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontsSizesManager.s11, color: AppColors.greyColor),
            ),
          ],
        ),
        Column(
          children: [
            ReusableText(
              text: '${widget.product.discountPrice}\$',
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: FontsSizesManager.s24),
            ),
            putVerticalSpace(AppSpacing.sp_20)
          ],
        )
      ],
    );
  }

  StatefulBuilder buildSizeDropMenu(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateSize) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: DropdownButton<String>(
          hint: ReusableText(
            text: 'Size',
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: FontsSizesManager.s14),
          ),
          onChanged: (newValue) {
            setStateSize(() {
              _selectedOption = newValue!;
            });
          },
          elevation: 1,
          items: [
            DropdownMenuItem(
              value: 'XXL',
              child: ReusableText(
                text: 'XXL',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
            DropdownMenuItem(
              value: 'XL',
              child: ReusableText(
                text: 'XL',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
            DropdownMenuItem(
              value: 'L',
              child: ReusableText(
                text: 'L',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
            DropdownMenuItem(
              value: '45L',
              child: ReusableText(
                text: '45L',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
            DropdownMenuItem(
              value: '40L',
              child: ReusableText(
                text: '40L',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
          ],
          underline: Container(),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }

  StatefulBuilder buildColorDropMenu(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateColor) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: DropdownButton<String>(
          hint: ReusableText(
            text: 'Color',
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: FontsSizesManager.s14),
          ),
          onChanged: (newValue) {
            setStateColor(() {
              _selectedOptionColor = newValue!;
            });
          },
          elevation: 1,
          items: [
            DropdownMenuItem(
              value: 'black',
              child: ReusableText(
                text: 'black',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
            DropdownMenuItem(
              value: 'blue',
              child: ReusableText(
                text: 'blue',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: FontsSizesManager.s14),
              ),
            ),
          ],
          underline: Container(),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }

  PreferredSize buildPreferredSizeForAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.08),
              spreadRadius: 6,
              blurRadius: 24.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: buildAppBar(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    List<String> wordsOfProductName = widget.product.name.split(' ');
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
        onPressed: () => Routing.goBack(context),
      ),
      title: ReusableText(
        text: '${wordsOfProductName[0]} ${wordsOfProductName[1]}',
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18.sp),
      ),
      actions: [
        const Icon(
          Icons.share,
        ),
        putHorizontalSpace(AppSpacing.sp_12),
      ],
    );
  }
}
