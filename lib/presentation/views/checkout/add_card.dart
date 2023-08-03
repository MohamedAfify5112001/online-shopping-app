import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/model/card_model.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/components/toast_comp.dart';

import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/btn_comp.dart';
import '../components/text_component.dart';
import '../components/text_form_field_comp.dart';

class AddingNewCardWidget extends StatefulWidget {
  const AddingNewCardWidget({
    super.key,
  });

  @override
  State<AddingNewCardWidget> createState() => _AddingNewCardWidgetState();
}

class _AddingNewCardWidgetState extends State<AddingNewCardWidget> {
  final nameOnCardController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expireDateController = TextEditingController();
  final cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cardNumberFormatter = LengthLimitingTextInputFormatter(19);

  bool val = false;
  bool isMasterCardOrVisa = true;

  @override
  void deactivate() {
    nameOnCardController.dispose();
    cardNumberController.dispose();
    expireDateController.dispose();
    cvvController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, stateCheckout) async {
          if (stateCheckout.addNewCardStatus == CheckoutStatus.success) {
            await Future.wait([
              getToastMessage(
                  msg: 'Your New Card is Added Successfully..',
                  toastMessage: ToastMessage.successToast),
              Routing.goBack(context)
            ]);
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sp_16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      putVerticalSpace(AppSpacing.sp_47),
                      ReusableTextFormField(
                        hintText: 'Name on card',
                        obscureText: false,
                        controller: nameOnCardController,
                        keyboardType: TextInputType.text,
                        validator: (valueNameCard) => valueNameCard!.isEmpty
                            ? "Enter Your Name On Card"
                            : null,
                      ),
                      putVerticalSpace(AppSpacing.sp_20),
                      ReusableTextFormField(
                        hintText: 'Card Number',
                        controller: cardNumberController,
                        suffixIconImage: isMasterCardOrVisa
                            ? GestureDetector(
                                onTap: () => setState(() =>
                                    isMasterCardOrVisa = !isMasterCardOrVisa),
                                child: const LocalImage(
                                    imagePath: 'assets/images/mastercard.png'),
                              )
                            : null,
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _cardNumberFormatter,
                          _CardNumberTextInputFormatter(),
                        ],
                        keyboardType: TextInputType.text,
                        validator: (valueNameCard) => valueNameCard!.isEmpty
                            ? "Enter Your Card Number"
                            : null,
                      ),
                      putVerticalSpace(AppSpacing.sp_20),
                      ReusableTextFormField(
                        hintText: 'Expire Date',
                        controller: expireDateController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (valueNameCard) => valueNameCard!.isEmpty
                            ? "Enter Expire Date of Your Card"
                            : null,
                      ),
                      putVerticalSpace(AppSpacing.sp_20),
                      ReusableTextFormField(
                        hintText: 'CVV',
                        controller: cvvController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (valueNameCard) =>
                            valueNameCard!.isEmpty ? "Enter CVV" : null,
                      ),
                      putVerticalSpace(AppSpacing.sp_29),
                      StatefulBuilder(
                        builder: (context, cardSetState) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: val,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (value) =>
                                      cardSetState(() => val = value!),
                                  activeColor: AppColors.blackColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                ReusableText(
                                    text: 'Use as default payment method',
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontSize: FontsSizesManager.s14)),
                              ],
                            ),
                            putVerticalSpace(AppSpacing.sp_22),
                            SizedBox(
                              width: double.infinity,
                              child: ReusableButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<CheckoutBloc>().add(
                                          AddNewCardEvent(
                                            cardModel: CardModel(
                                                nameOnCard: nameOnCardController
                                                    .text
                                                    .trim(),
                                                cardNumber: cardNumberController
                                                    .text
                                                    .trim(),
                                                expireDate: expireDateController
                                                    .text
                                                    .trim(),
                                                cvv: cvvController.text.trim(),
                                                isDefault: val,
                                                isMasterCardOrVisa:
                                                    isMasterCardOrVisa),
                                          ),
                                        );
                                  }
                                },
                                text: 'ADD CARD',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: FontsSizesManager.s14,
                                      color: AppColors.whiteColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        text: "Add new card",
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18),
      ),
    );
  }
}

class _CardNumberTextInputFormatter extends TextInputFormatter {
  static const int _groupSize = 4;

  // This is the character used to separate the groups
  static const String _separator = ' ';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    final int newTextLength = newValue.text.length;

    for (int i = 0; i < newTextLength; i += _groupSize) {
      final int end = i + _groupSize;
      if (end < newTextLength) {
        newText.write(newValue.text.substring(i, end) + _separator);
      } else {
        newText.write(newValue.text.substring(i));
        break;
      }
    }

    return newValue.copyWith(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
