import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/data/cache/caching_comp.dart';
import 'package:online_shopping/token/app_colors.dart';
import 'package:online_shopping/token/routing.dart';

import '../components/local_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuth();
  }

  _navigateToAuth() async {
    final String uId = CachingStorage.getUId(key: 'uId');
    await Future.delayed(
        const Duration(seconds: 5),
        () => uId.isNotEmpty
            ? Routing.replaceWith(context, Routing.layout)
            : Routing.replaceWith(context, Routing.signUpRoute));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/images/logo.jpg"), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: FadeInLeftBig(
        child: const Center(
          child: LocalImage(
            imagePath: 'assets/images/logo.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
