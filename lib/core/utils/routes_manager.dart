import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/moka/presentation/screens/carts/general_cart_screen.dart';
import 'package:moka_store/moka/presentation/screens/category_see_more/category_details_screen.dart';
import 'package:moka_store/moka/presentation/screens/category_see_more/catogry_items_screen.dart';
import 'package:moka_store/moka/presentation/screens/item_details/item_details_screen.dart';
import 'package:moka_store/moka/presentation/screens/search/search_screen.dart';

import '../../config/shared/component.dart';
import '../../moka/presentation/screens/main/main_screen.dart';
import '../../moka/presentation/screens/onboarding/onboarding_screen.dart';
import '../../moka/presentation/screens/payment/cash_screen.dart';
import '../../moka/presentation/screens/payment/payment_toggle_screen.dart';
import '../../moka/presentation/screens/payment/visa_screen.dart';
import '../../moka/presentation/screens/splash/splash_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String categorySeeMoreRoute = "/category";
  static const String categoryItemsRoute = "/categoryItems";
  static const String itemDetailsRoute = "/itemDetails";
  static const String searchRoute = "/search";
  static const String generalCartRoute = "/cart";
  static const String toggleRoute = "/toggle";
  static const String cashRoute = "/cash";
  static const String visaRoute = "/visa";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onBoardingRoute:
        return SlideTransition1(const OnBoardingScreen());

      case Routes.mainRoute:
        return SlideTransition1(const MainHomeZoom());

      case Routes.categorySeeMoreRoute:
        return SlideTransition1(const CategorySeeMoreScreen());

      case Routes.categoryItemsRoute:
        List<dynamic>? args = settings.arguments as List?;
        return SlideTransition1(CategoryItemsScreen(
          item: args![AppConstants.cI0],
          appbarTitle: args[AppConstants.cI1],
        ));

      case Routes.itemDetailsRoute:
        return SlideTransition1(ItemDetailsScreen(
          item: settings.arguments,
        ));

      case Routes.searchRoute:
        return SlideTransition1(SearchScreen(
          listSearch: settings.arguments,
        ));

      case Routes.generalCartRoute:
        return SlideTransition1(const GeneralCartScreen());

      case Routes.toggleRoute:
        return SlideTransition1(const ToggleScreen());

      case Routes.cashRoute:
        return SlideTransition1(const CashScreen());

      case Routes.visaRoute:
        return SlideTransition1(const VisaScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
