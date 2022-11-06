import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/font_manager.dart';

import '../../../config/locale/app_localizations.dart';
import '../../../core/utils/constants_manager.dart';
import '../../../core/utils/values_manager.dart';
import '../controller/moka_bloc.dart';

class BasicNoFoundScreen extends StatelessWidget {
  final String image;
  final String name;

  const BasicNoFoundScreen({required this.image, required this.name, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          Text(
            name,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Text(
            AppLocalizations.of(context)!.translate('no_found')!,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(height: AppFontSize.s1_3),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            width: AppSize.s250,
            height: AppSize.s50,
            child: ElevatedButton(
              onPressed: () {
                MokaBloc.get(context)
                    .add(const ChangeIndexEvent(AppConstants.cI0));
              },
              child: Text(
                AppLocalizations.of(context)!.translate('start_ordering')!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
