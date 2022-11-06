import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:moka_store/core/utils/assets_manager.dart';
import 'package:moka_store/core/utils/color_manager.dart';

import '../../../../core/utils/strings_manager.dart';

final pages = [
  PageModel(
    color: AppColor.onBoarding1,
    imageAssetPath: ImageAssets.onboardingLogo1,
    title: AppStrings.onBoardingTitle1,
    body: AppStrings.onBoardingSubTitle1,
    doAnimateImage: true,
  ),
  PageModel(
    color: AppColor.onBoarding2,
    imageAssetPath: ImageAssets.onboardingLogo2,
    title: AppStrings.onBoardingTitle2,
    body: AppStrings.onBoardingSubTitle2,
    doAnimateImage: true,
  ),
  PageModel(
    color: AppColor.onBoarding3,
    imageAssetPath: ImageAssets.onboardingLogo3,
    title: AppStrings.onBoardingTitle3,
    body: AppStrings.onBoardingSubTitle3,
    doAnimateImage: true,
  ),
];
