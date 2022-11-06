import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'constants_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    // main colors
    primaryColor: AppColor.primary,
    primaryColorLight: AppColor.lightPrimary,
    primaryColorDark: AppColor.darkPrimary,
    disabledColor: AppColor.grey1,
    splashColor: AppColor.grey1,
    scaffoldBackgroundColor: AppColor.scaffoldLightBackGround,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primary,
      secondary: AppColor.primary,
    ),
    // card view theme
    cardTheme: const CardTheme(
      color: AppColor.white,
      shadowColor: AppColor.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColor.scaffoldLightBackGround,
        elevation: AppConstants.cD0,
        shadowColor: AppColor.lightPrimary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme:
            const IconThemeData(color: AppColor.black, size: AppFontSize.s28),
        titleTextStyle: getBoldStyle(
          fontSize: AppFontSize.s22,
          color: AppColor.black,
        )),

    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: AppColor.grey1,
      buttonColor: AppColor.primary,
      splashColor: AppColor.lightPrimary,
    ),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: AppColor.white, fontSize: AppFontSize.s17),
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              AppSize.s12,
            )))),

    // text theme
    textTheme: TextTheme(
      displayLarge:
          getBoldStyle(color: AppColor.black, fontSize: AppFontSize.s22),
      headlineLarge:
          getSemiBoldStyle(color: AppColor.black, fontSize: AppFontSize.s24),
      titleMedium:
          getMediumStyle(color: AppColor.white, fontSize: AppFontSize.s16),
      bodyLarge:
          getMediumStyle(color: AppColor.primary, fontSize: AppFontSize.s14),
      bodySmall: getRegularStyle(
        color: AppColor.black,
        fontSize: AppFontSize.s16,
      ),
    ),
    fontFamily: AppFontConstants.fontFamily,

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getRegularStyle(color: AppColor.grey, fontSize: AppFontSize.s14),
        labelStyle:
            getMediumStyle(color: AppColor.grey, fontSize: AppFontSize.s14),
        errorStyle: getRegularStyle(color: AppColor.error),

        // enabled border style
        enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.grey, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    // main colors
    primaryColor: AppColor.primary,
    primaryColorLight: AppColor.lightPrimary,
    primaryColorDark: AppColor.darkPrimary,
    disabledColor: AppColor.grey1,
    splashColor: AppColor.grey1,
    scaffoldBackgroundColor: AppColor.scaffoldDarkBackGround,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primary,
      secondary: AppColor.primary,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColor.scaffoldDarkBackGround,
        elevation: AppConstants.cD0,
        shadowColor: AppColor.lightPrimary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme:
            const IconThemeData(color: AppColor.white, size: AppFontSize.s28),
        titleTextStyle: getBoldStyle(
          fontSize: AppFontSize.s22,
          color: AppColor.white,
        )),

    // text theme
    textTheme: TextTheme(
      displayLarge:
          getBoldStyle(color: AppColor.white, fontSize: AppFontSize.s22),
      headlineLarge:
          getSemiBoldStyle(color: AppColor.white, fontSize: AppFontSize.s24),
      titleMedium:
          getMediumStyle(color: AppColor.white, fontSize: AppFontSize.s16),
      bodyLarge:
          getMediumStyle(color: AppColor.primary, fontSize: AppFontSize.s14),
      bodySmall: getRegularStyle(
        color: AppColor.white,
        fontSize: AppFontSize.s16,
      ),
    ),
  );
}
