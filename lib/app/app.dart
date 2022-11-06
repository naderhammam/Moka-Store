import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/helper/cache_helper.dart';
import '../config/locale/app_localizations_setup.dart';
import '../core/services/services_locator.dart';
import '../core/utils/constants_manager.dart';
import '../core/utils/routes_manager.dart';
import '../core/utils/theme_manager.dart';
import '../moka/presentation/controller/moka_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isDark = CacheHelper.getData(key: AppConstants.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (isDark == null) {
          CacheHelper.saveData(key: AppConstants.isDark, value: false)
              .then((value) {
            isDark = value;
          });
        }

        return sl<MokaBloc>()
          ..add(GetElectronicsProductEvent())
          ..add(GetSupermarketProductEvent())
          ..add(GetMenProductEvent())
          ..add(GetWomenProductEvent())
          ..add(GetWatchesProductEvent())
          ..add(GetAllProductEvent())
          ..add(CreateDataBaseEvent())
          ..add(changeModeEvent(isDark ?? false))
          ..add(getSavedLangEvent());
      },
      child: BlocBuilder<MokaBloc, MokaState>(
        buildWhen: (previous, current) =>
            previous.isDark != current.isDark ||
            previous.locale != current.locale,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationLightTheme(),
            darkTheme: getApplicationDarkTheme(),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            initialRoute: Routes.splashRoute,
            onGenerateRoute: RouteGenerator.getRoute,
            locale: state.locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
          );
        },
      ),
    );
  }
}
