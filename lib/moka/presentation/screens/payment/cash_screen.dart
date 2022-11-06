import 'package:flutter/material.dart';
import 'package:moka_store/core/network/api_constance.dart';
import 'package:moka_store/core/utils/color_manager.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/core/utils/font_manager.dart';
import 'package:moka_store/core/utils/strings_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/shared/component.dart';
import '../../../../core/utils/icons_manager.dart';
import '../../controller/moka_bloc.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.translate('payment_by_cash')!),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppPadding.p4,
            ),
            child: IconButton(
                onPressed: () {
                  backToHome(context, AppStrings.backToHomeCash);
                },
                icon: const Icon(
                  IconBroken.Home,
                )),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: AppSize.s24,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.translate('go_to_supermarket')!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppLocalizations.of(context)!.translate('number_of_order')!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: AppFontSize.s18,
                    color: MokaBloc.get(context).state.isDark
                        ? AppColor.white
                        : AppColor.black,
                    height: AppSize.s1_5,
                  ),
            ),
            const SizedBox(height: AppSize.s20),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppColor.primary,
                  width: AppConstants.cD2,
                ),
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),
              elevation: AppConstants.cD10,
              color: MokaBloc.get(context).state.isDark
                  ? AppColor.scaffoldDarkBackGround
                  : AppColor.scaffoldLightBackGround,
              child: Padding(
                padding: const EdgeInsets.all(AppSize.s8),
                child: SelectableText(
                  ApiConstance.REFCODE,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: AppSize.s40,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
