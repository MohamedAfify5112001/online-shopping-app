import 'package:flutter/material.dart';
import 'package:online_shopping/presentation/views/checkout/shipping_address_items_screen.dart';
import 'package:online_shopping/presentation/views/layout/layout_screen.dart';
import 'package:online_shopping/presentation/views/my-order/my_order_screen.dart';
import 'package:online_shopping/presentation/views/payment-methods/payment_methods_screen.dart';
import 'package:online_shopping/presentation/views/shop/category_items_screen.dart';
import 'package:online_shopping/presentation/views/success-screen/success_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../presentation/views/forgot-password/forgot_password.dart';
import '../presentation/views/sign-in/sign_in_screen.dart';
import '../presentation/views/sign-up/sign_up_screen.dart';
import '../presentation/views/splash/splash_screen.dart';

sealed class Routing {
  Routing._();

  static const String splashRoute = '/';
  static const String signUpRoute = '/signup';
  static const String signInRoute = '/signin';
  static const String forgotPassword = '/forgotpassword';
  static const String layout = '/layout';
  static const String categoryItems = '/category-items';
  static const String success = '/success';
  static const String shipping = '/shipping';
  static const String payment = '/payment';
  static const String myOrder = '/myOrder';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return PageTransition(
          child: const SplashScreen(),
          duration: const Duration(milliseconds: 1500),
          type: PageTransitionType.rightToLeft,
        );
      case signUpRoute:
        return PageTransition(
            child: const SignUpScreen(),
            type: PageTransitionType.rightToLeft,
            reverseDuration: const Duration(milliseconds: 1500),
            duration: const Duration(milliseconds: 1500),
            settings: settings);

      case signInRoute:
        return PageTransition(
            child: const SignInScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);

      case forgotPassword:
        return PageTransition(
            child: const ForgotPasswordScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);

      case layout:
        return PageTransition(
            child: const LayoutScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);
      case success:
        return PageTransition(
            child: const SuccessScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);
      case shipping:
        return PageTransition(
            child: const ShippingAddressItemsScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);
      case payment:
        return PageTransition(
            child: const PaymentMethodsScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);
      case myOrder:
        return PageTransition(
            child: const MyOrderScreen(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }

  static Future<void> navigateTo(BuildContext context, String routeName) async {
    await Navigator.pushNamed(context, routeName);
  }

  static Future<void> replaceWith(
      BuildContext context, String routeName) async {
    await Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  static Future<void> removeWith(BuildContext context, String routeName) async {
    await Navigator.pushNamedAndRemoveUntil(
        context, routeName, (route) => false);
  }

  static Future<void> goBack(BuildContext context, [dynamic result]) async {
    Navigator.pop(context, result);
  }
}
