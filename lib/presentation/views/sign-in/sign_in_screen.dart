import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/data/cache/caching_comp.dart';
import 'package:online_shopping/data/network/requests.dart';
import 'package:online_shopping/presentation/view_model/auth/authentication_bloc.dart';
import 'package:online_shopping/token/extensions.dart';

import '../../../token/app_colors.dart';
import '../../../token/routing.dart';
import '../../../token/theme/font_sizes.dart';
import '../../../token/theme/padding_values.dart';
import '../../../token/theme/spacing.dart';
import '../components/btn_comp.dart';
import '../components/empty_space.dart';
import '../components/local_images.dart';
import '../components/social.dart';
import '../components/text_component.dart';
import '../components/text_form_field_comp.dart';
import '../components/toast_comp.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
                if (state is SignInFailureState) {
                  getToastMessage(
                      msg: state.logInWithEmailAndPasswordFailure.message,
                      toastMessage: ToastMessage.errorToast);
                } else if (state is SignInSuccessState) {
                  getToastMessage(
                          msg: 'Logged in successfully',
                          toastMessage: ToastMessage.successToast)
                      .then(
                    (value) {
                      if (kDebugMode) {
                        print("UIIIIIIIIIIIIIIID${state.uId}");
                      }
                      CachingStorage.storeUId(key: 'uId', val: state.uId).then(
                          (value) =>
                              Routing.removeWith(context, Routing.layout));
                    },
                  );
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
                            text: "Login",
                            textStyle:
                                Theme.of(context).textTheme.displayLarge!),
                      ),
                      putVerticalSpace(AppSpacing.sp_73),
                      FadeInRightBig(
                        delay: const Duration(milliseconds: 900),
                        child: ReusableTextFormField(
                          controller: emailController,
                          onChanged: (value) => context
                              .read<AuthenticationBloc>()
                              .add(ValidateEmailSignInEvent(
                                  email: value.trim())),
                          colorSuffixIcon: state is ValidSignInEmailState
                              ? AppColors.successColor
                              : state is NotValidSignInEmailState
                                  ? AppColors.errorColor
                                  : null,
                          suffixIcon: state is ValidSignInEmailState
                              ? Icons.done
                              : state is NotValidSignInEmailState
                                  ? Icons.close
                                  : null,
                          hintText: "Email",
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
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
                        delay: const Duration(milliseconds: 1200),
                        child: ReusableTextFormField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
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
                          keyboardType: TextInputType.text,
                          onChanged: (password) => context
                              .read<AuthenticationBloc>()
                              .add(
                                ValidatePasswordSignInEvent(password: password),
                              ),
                          colorSuffixIcon: state is ValidPasswordSignInState
                              ? AppColors.successColor
                              : state is NotValidPasswordSignInState
                                  ? AppColors.errorColor
                                  : null,
                          suffixIcon: state is ValidPasswordSignInState
                              ? Icons.done
                              : state is NotValidPasswordSignInState
                                  ? Icons.close
                                  : null,
                        ),
                      ),
                      putVerticalSpace(AppSpacing.sp_16),
                      FadeInLeftBig(
                        delay: const Duration(milliseconds: 1400),
                        child: Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () => Routing.navigateTo(
                                  context, Routing.forgotPassword),
                              child: ReusableText(
                                text: "Forgot your password?",
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
                      putVerticalSpace(AppSpacing.sp_32),
                      (state is SignInLoadingState)
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : FadeInRightBig(
                              delay: const Duration(milliseconds: 1700),
                              child: SizedBox(
                                width: double.infinity.w,
                                height: AppSpacing.sp_48.h,
                                child: ReusableButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthenticationBloc>().add(
                                          SignInAuthEvent(
                                              authenticationRequest:
                                                  SignInAuthenticationRequest(
                                                      email: emailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim())));
                                    }
                                  },
                                  text: "Login",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: FontsSizesManager.s14.sp),
                                ),
                              ),
                            ),
                      putVerticalSpace(AppSpacing.sp_194),
                      FadeInUpBig(
                        delay: const Duration(milliseconds: 2200),
                        child: Center(
                          child: ReusableText(
                            text: "Or login with social account",
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
                            const ReusableSocial(
                              imagePath: 'assets/images/google.png',
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
