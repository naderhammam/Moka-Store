import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:moka_store/core/utils/color_manager.dart';
import 'package:moka_store/core/utils/font_manager.dart';
import 'package:moka_store/core/utils/strings_manager.dart';

import '../../../../config/helper/cache_helper.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _controller;

  _startDelay() {
    _timer =
        Timer(const Duration(milliseconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, nextScreen());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              ImageAssets.splashAnimation,
              controller: _controller,
              repeat: false,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward();
              },
            ),
            FadeTransition(
              opacity:
                  Tween<double>(begin: AppConstants.cD0, end: AppConstants.cD1)
                      .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(AppConstants.cD0, AppConstants.cD0_5,
                      curve: Curves.easeIn),
                ),
              ),
              child: Text(
                AppStrings.appName,
                style: GoogleFonts.bungee(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColor.white, fontSize: AppFontSize.s34),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String nextScreen() {
    late String home;
    if (CacheHelper.getData(key: AppConstants.cacheOnBoardingKey) != null) {
      home = Routes.mainRoute;
    } else {
      home = Routes.onBoardingRoute;
    }
    return home;
  }
}
