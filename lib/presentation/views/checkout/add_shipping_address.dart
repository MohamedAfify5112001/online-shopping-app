import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/presentation/views/components/empty_space.dart';
import 'package:online_shopping/presentation/views/components/text_form_field_comp.dart';
import 'package:online_shopping/token/theme/spacing.dart';

import '../../../model/shipping_address_model.dart';
import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../view_model/checkout/checkout_bloc.dart';
import '../components/btn_comp.dart';
import '../components/text_component.dart';
import '../components/toast_comp.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({Key? key}) : super(key: key);

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final regionOrStateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void deactivate() {
    fullNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    regionOrStateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
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
          if (stateCheckout.addNewShippingAddressStatus ==
              CheckoutStatus.success) {
            await Future.wait([
              getToastMessage(
                  msg: 'Your New Shipping Address is Added Successfully..',
                  toastMessage: ToastMessage.successToast),
              Routing.goBack(context),
            ]);
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sp_16, vertical: AppSpacing.sp_35),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableTextFormField(
                      hintText: 'Full name',
                      controller: fullNameController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (valueNameCard) =>
                          valueNameCard!.isEmpty ? "Enter Full name" : null,
                    ),
                    putVerticalSpace(AppSpacing.sp_20),
                    ReusableTextFormField(
                      hintText: 'Address',
                      controller: addressController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (valueNameCard) =>
                          valueNameCard!.isEmpty ? "Enter Your Address" : null,
                    ),
                    putVerticalSpace(AppSpacing.sp_20),
                    ReusableTextFormField(
                      hintText: 'City',
                      controller: cityController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (valueNameCard) =>
                          valueNameCard!.isEmpty ? "Enter Your City" : null,
                    ),
                    putVerticalSpace(AppSpacing.sp_20),
                    ReusableTextFormField(
                      hintText: 'State/Province/Region',
                      controller: regionOrStateController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (valueNameCard) => valueNameCard!.isEmpty
                          ? "Enter Your State/Province/Region"
                          : null,
                    ),
                    putVerticalSpace(AppSpacing.sp_20),
                    ReusableTextFormField(
                      hintText: 'Zip Code (Postal Code)',
                      controller: zipCodeController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (valueNameCard) =>
                          valueNameCard!.isEmpty ? "Enter Your Zip Code" : null,
                    ),
                    putVerticalSpace(AppSpacing.sp_20),
                    ReusableTextFormField(
                      hintText: 'Country',
                      controller: countryController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      validator: (valueNameCard) =>
                          valueNameCard!.isEmpty ? "Enter Your Country" : null,
                    ),
                    putVerticalSpace(AppSpacing.sp_40),
                    SizedBox(
                      width: double.infinity,
                      child: ReusableButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<CheckoutBloc>().add(
                                  AddNewShippingAddress(
                                    shippingAddressModel: ShippingAddressModel(
                                      fullName: fullNameController.text.trim(),
                                      address: addressController.text.trim(),
                                      city: cityController.text.trim(),
                                      state:
                                          regionOrStateController.text.trim(),
                                      zipCode: zipCodeController.text.trim(),
                                      country: countryController.text.trim(),
                                    ),
                                  ),
                                );
                          }
                        },
                        text: 'SAVE ADDRESS',
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
        text: 'Adding Shipping Address',
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: FontsSizesManager.s18),
      ),
    );
  }
}
