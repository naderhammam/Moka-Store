import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/font_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/routes_manager.dart';
import '../../core/utils/strings_manager.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = AppSize.s60,
  Color backgroundColor = AppColor.primary,
  Color borderColor = AppColor.primary,
  Color fontColor = Colors.white,
  bool isUpperCase = true,
  double radius = AppSize.s3,
  double borderWidth = 0,
  double fontSize = AppFontSize.s16,
  required Function function,
  required String text,
  IconData? prefix,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null)
              Icon(
                prefix,
                size: AppSize.s20,
                color: AppColor.white,
              ),
            if (prefix != null)
              const SizedBox(
                width: AppSize.s20,
              ),
            Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );

void backToHome(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s18)),
          actionsPadding: EdgeInsetsDirectional.only(
            bottom: AppPadding.p10,
          ),
          title: Text(AppStrings.areYouSure,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColor.primary,
                  )),
          content: Text(text,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: AppSize.s16,
                    color: AppColor.black,
                  )),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            Container(
              width: AppSize.s100,
              height: AppSize.s40,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(AppSize.s5),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.mainRoute,
                    (route) => false,
                  );
                },
                child: Text(
                  AppStrings.yes,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Container(
              width: AppSize.s100,
              height: AppSize.s40,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(AppSize.s5),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppStrings.no,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        );
      });
}

class SlideTransition1 extends PageRouteBuilder {
  final Widget page;

  SlideTransition1(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: Duration(milliseconds: 1000),
            reverseTransitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                child: page,
              );
            });
}
