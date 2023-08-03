import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/presentation/view_model/auth/authentication_bloc.dart';
import 'package:online_shopping/token/extensions.dart';
import 'package:online_shopping/token/routing.dart';
import 'package:online_shopping/token/theme/font_sizes.dart';

import '../../../token/app_colors.dart';
import '../../../token/theme/padding_values.dart';
import '../../../token/theme/spacing.dart';
import '../components/btn_comp.dart';
import '../components/empty_space.dart';
import '../components/text_component.dart';
import '../components/text_form_field_comp.dart';
import '../components/toast_comp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void deactivate() {
    emailController.dispose();
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
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.s14.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is ForgotPasswordFailureState) {
                  getToastMessage(
                      msg: state.error, toastMessage: ToastMessage.errorToast);
                } else if (state is ForgotPasswordSuccessState) {
                  getToastMessage(
                          msg: 'Password reset email sent',
                          toastMessage: ToastMessage.successToast)
                      .then((value) => Routing.goBack(context));
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      putVerticalSpace(AppSpacing.sp_18),
                      FadeInLeftBig(
                        child: ReusableText(
                            text: "Forgot password",
                            textStyle:
                                Theme.of(context).textTheme.displayLarge!),
                      ),
                      putVerticalSpace(AppSpacing.sp_87),
                      FadeInRightBig(
                        delay: const Duration(milliseconds: 900),
                        child: ReusableText(
                            text:
                                "Please, enter your email address. You will receive a link to create a new password via email.",
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: FontsSizesManager.s14,
                                )),
                      ),
                      putVerticalSpace(AppSpacing.sp_16),
                      FadeInLeftBig(
                        delay: const Duration(milliseconds: 1100),
                        child: ReusableTextFormField(
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context
                              .read<AuthenticationBloc>()
                              .add(ValidateEmailForgotPasswordEvent(
                                  email: value.trim())),
                          colorSuffixIcon:
                              state is ValidForgotPasswordEmailState
                                  ? AppColors.successColor
                                  : state is NotValidForgotPasswordEmailState
                                      ? AppColors.errorColor
                                      : null,
                          suffixIcon: state is ValidForgotPasswordEmailState
                              ? Icons.done
                              : state is NotValidForgotPasswordEmailState
                                  ? Icons.close
                                  : null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Email';
                            } else {
                              if (!value.isValidEmail()) {
                                return 'Not a valid email address. Should be your@email.com';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      putVerticalSpace(AppSpacing.sp_55),
                      (state is ForgotPasswordLoadingState)
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : FadeInUpBig(
                              delay: const Duration(milliseconds: 1300),
                              child: SizedBox(
                                width: double.infinity.w,
                                height: AppSpacing.sp_48.h,
                                child: ReusableButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthenticationBloc>().add(
                                          ForgotPasswrodEvent(
                                              email:
                                                  emailController.text.trim()));
                                    }
                                  },
                                  text: "SEND",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: FontsSizesManager.s14.sp),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
