import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/presentation/view_model/auth/authentication_bloc.dart';
import 'package:online_shopping/presentation/view_model/bag/bag_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/view_model/favorites/favorites_bloc.dart';
import 'package:online_shopping/presentation/view_model/home/banner/banner_bloc.dart';
import 'package:online_shopping/presentation/view_model/layout/layout_bloc.dart';
import 'package:online_shopping/presentation/view_model/product/product_bloc.dart';
import 'package:online_shopping/token/get_dI.dart';
import 'package:online_shopping/token/routing.dart';
import 'package:online_shopping/token/theme/theme_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineShoppingApp extends StatelessWidget {
  OnlineShoppingApp._internal();

  static OnlineShoppingApp get _instance => OnlineShoppingApp._internal();

  factory OnlineShoppingApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => instance<AuthenticationBloc>()),
          BlocProvider(create: (_) => instance<LayoutBloc>()),
          BlocProvider(
            create: (_) =>
                instance<BannerBloc>()..add(const BannerFetchedEvent()),
          ),
          BlocProvider(
              create: (_) => instance<ProductBloc>()
                ..add(const FetchNewProductEvent())
                ..add(const FetchShoesProductEvent())
                ..add(const FetchAccessoriesProductEvent())),
          BlocProvider(create: (_) => instance<FavoritesBloc>()),
          BlocProvider(create: (_) => instance<BagBloc>()),
          BlocProvider(create: (_) => instance<CheckoutBloc>()),
        ],
        child: MaterialApp(
          theme: getAppTheme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routing.generateRoute,
          initialRoute: Routing.splashRoute,
        ),
      ),
    );
  }
}
