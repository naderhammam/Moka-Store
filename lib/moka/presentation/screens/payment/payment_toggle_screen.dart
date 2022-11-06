import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/assets_manager.dart';
import 'package:moka_store/core/utils/color_manager.dart';
import 'package:moka_store/core/utils/routes_manager.dart';
import 'package:moka_store/core/utils/strings_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/shared/component.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backToHome(context, AppStrings.backToHomeBase);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('app_name')!),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p16,
            right: AppPadding.p16,
            bottom: AppPadding.p16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.visaRoute,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      border: Border.all(color: AppColor.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.asset(
                              ImageAssets.card,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('payment_by_card')!,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: AppSize.s18,
                              ),
                        ),
                        const SizedBox(height: AppSize.s10),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s24),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.cashRoute);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.asset(
                              ImageAssets.machineCard,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('payment_by_cash')!,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: AppSize.s18,
                              ),
                        ),
                        const SizedBox(height: AppSize.s10),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s8),
            ],
          ),
        ),
      ),
    );
  }
}
