import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/data/network/requests.dart';
import 'package:online_shopping/presentation/view_model/auth/authentication_bloc.dart';
import 'package:online_shopping/presentation/views/components/local_images.dart';
import 'package:online_shopping/presentation/views/components/text_component.dart';
import 'package:online_shopping/presentation/views/components/toast_comp.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/extensions.dart';
import 'package:online_shopping/token/theme/padding_values.dart';

import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/spacing.dart';
import '../components/btn_comp.dart';
import '../components/empty_space.dart';
import '../components/social.dart';
import '../components/text_form_field_comp.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool? isValid;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                if (state is SignUpFailureState) {
                  getToastMessage(
                      msg: state.signUpWithEmailAndPasswordFailure.message,
                      toastMessage: ToastMessage.errorToast);
                } else if (state is SignUpSuccessState) {
                  getToastMessage(
                          msg: 'Account is created successfully',
                          toastMessage: ToastMessage.successToast)
                      .then((value) =>
                          Routing.removeWith(context, Routing.layout));
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
                            text: "Sign up",
                            textStyle:
                                Theme.of(context).textTheme.displayLarge!),
                      ),
                      putVerticalSpace(AppSpacing.sp_73),
                      FadeInRightBig(
                        delay: const Duration(milliseconds: 900),
                        child: ReusableTextFormField(
                          controller: nameController,
                          hintText: "Name",
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Name';
                            } else {
                              if (!value.isValidName()) {
                                return 'Not a valid Name. Should be containing more than \n 10 characters';
                              }
                            }
                            return null;
                          },
                          suffixIcon: state is ValidNameState
                              ? Icons.done
                              : state is NotValidNameState
                                  ? Icons.close
                                  : null,
                          colorSuffixIcon: state is ValidNameState
                              ? AppColors.successColor
                              : state is NotValidNameState
                                  ? AppColors.errorColor
                                  : null,
                          onChanged: (value) =>
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(ValidateNameEvent(name: value.trim())),
                        ),
                      ),
                      putVerticalSpace(AppSpacing.sp_8),
                      FadeInRightBig(
                        delay: const Duration(milliseconds: 1200),
                        child: ReusableTextFormField(
                          onChanged: (value) => context
                              .read<AuthenticationBloc>()
                              .add(ValidateEmailEvent(email: value.trim())),
                          colorSuffixIcon: state is ValidEmailState
                              ? AppColors.successColor
                              : state is NotValidEmailState
                                  ? AppColors.errorColor
                                  : null,
                          suffixIcon: state is ValidEmailState
                              ? Icons.done
                              : state is NotValidEmailState
                                  ? Icons.close
                                  : null,
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                          keyboardType: TextInputType.text,
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
                      putVerticalSpace(AppSpacing.sp_8),
                      FadeInRightBig(
                        delay: const Duration(milliseconds: 1400),
                        child: ReusableTextFormField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => context
                              .read<AuthenticationBloc>()
                              .add(ValidatePasswordEvent(
                                  password: value.trim())),
                          colorSuffixIcon: state is ValidPasswordState
                              ? AppColors.successColor
                              : state is NotValidPasswordState
                                  ? AppColors.errorColor
                                  : null,
                          suffixIcon: state is ValidPasswordState
                              ? Icons.done
                              : state is NotValidPasswordState
                                  ? Icons.close
                                  : null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Password';
                            } else {
                              if (!value.isValidPassword()) {
                                return 'Not a valid Password. Should be \n At least 8 characters long \n Contains at least one letter and one number \n May contain special characters like @\$!%*#?&';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      putVerticalSpace(AppSpacing.sp_16),
                      FadeInLeftBig(
                        delay: const Duration(milliseconds: 1700),
                        child: Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () => Routing.removeWith(
                                  context, Routing.signInRoute),
                              child: ReusableText(
                                text: "Already have an account?",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: FontsSizesManager.s14.sp),
                              ),
                            ),
                            putHorizontalSpace(AppSpacing.sp_4),
                            const LocalImage(
                                imagePath: 'assets/images/arrow.png'),
                          ],
                        ),
                      ),
                      putVerticalSpace(AppSpacing.sp_28),
                      (state is SignUpLoadingState)
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : FadeInRightBig(
                              delay: const Duration(milliseconds: 2000),
                              child: SizedBox(
                                width: double.infinity.w,
                                height: AppSpacing.sp_48.h,
                                child: ReusableButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthenticationBloc>().add(
                                            SignUpAuthEvent(
                                              authenticationRequest:
                                                  SignUpAuthenticationRequest(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                                name:
                                                    nameController.text.trim(),
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  text: "SIGN UP",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: FontsSizesManager.s14.sp),
                                ),
                              ),
                            ),
                      putVerticalSpace(AppSpacing.sp_126),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2200),
                        child: Center(
                          child: ReusableText(
                            text: "Or sign up with social account",
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: FontsSizesManager.s14.sp),
                          ),
                        ),
                      ),
                      putVerticalSpace(AppSpacing.sp_12),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: const ReusableSocial(
                                imagePath: 'assets/images/google.png',
                              ),
                              onTap: () => context
                                  .read<AuthenticationBloc>()
                                  .add(const SignUpWithGoogleEvent()),
                            ),
                            putHorizontalSpace(AppSpacing.sp_16),
                            const ReusableSocial(
                              imagePath: 'assets/images/face.png',
                            ),
                          ],
                        ),
                      )
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
