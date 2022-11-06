import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

import '../../../../config/helper/cache_helper.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import 'onboarding_items.dart';

final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          submit(context);
        },
        finishCallback: () {
          submit(context);
        },
      ),
    );
  }

  void submit(context) {
    CacheHelper.saveData(key: AppConstants.cacheOnBoardingKey, value: true)
        .then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
