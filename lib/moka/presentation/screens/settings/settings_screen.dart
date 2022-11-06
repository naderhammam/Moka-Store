import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';
import 'package:moka_store/moka/presentation/controller/moka_bloc.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/font_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p50,
          left: AppPadding.p20,
          right: AppPadding.p20,
          bottom: AppPadding.p20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSize.s16),
                Text(AppLocalizations.of(context)!.translate('account')!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: AppFontSize.s22,
                      color: MokaBloc.get(context).state.isDark
                          ? Colors.white
                          : Colors.black,
                    )),
                const SizedBox(height: AppSize.s16),
                Container(
                  height: AppSize.s80,
                  padding: const EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    color: MokaBloc.get(context).state.isDark
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: AppSize.s50,
                        height: AppSize.s50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MokaBloc.get(context).state.isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade300,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: AppSize.s30,
                            color: MokaBloc.get(context).state.isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade500, //500 when light
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSize.s16),
                      Text(
                          "${AppLocalizations.of(context)!.translate('login')!} / ${AppLocalizations.of(context)!.translate('register')!}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                Text(AppLocalizations.of(context)!.translate('settings')!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: AppFontSize.s22,
                      color: MokaBloc.get(context).state.isDark
                          ? Colors.white
                          : Colors.black,
                    )),
                const SizedBox(height: AppSize.s16),
                _buildListTile(
                  context,
                  AppLocalizations.of(context)!.translate('appearance')!,
                  Icons.dark_mode,
                  MokaBloc.get(context).state.isDark
                      ? AppLocalizations.of(context)!.translate('dark_mode')!
                      : AppLocalizations.of(context)!.translate('light_mode')!,
                  Colors.purple,
                  theme,
                  onTab: () => _showAppearanceModal(theme, context),
                ),
                // }),
                const SizedBox(height: AppSize.s8),
                _buildListTile(
                    context,
                    AppLocalizations.of(context)!.translate('language')!,
                    Icons.language,
                    AppLocalizations.of(context)!.isEnLocale
                        ? AppLocalizations.of(context)!.translate('english')!
                        : AppLocalizations.of(context)!.translate('arabic')!,
                    Colors.orange,
                    theme, onTab: () {
                  _showAppearanceModalLang(theme, context);
                }),
                const SizedBox(height: AppSize.s8),
                _buildListTile(
                    context,
                    AppLocalizations.of(context)!.translate('notifications')!,
                    Icons.notifications_outlined,
                    '',
                    Colors.blue,
                    theme,
                    onTab: () {}),
                const SizedBox(height: AppSize.s8),
                _buildListTile(
                    context,
                    AppLocalizations.of(context)!.translate('help')!,
                    Icons.help,
                    '',
                    Colors.green,
                    theme,
                    onTab: () {}),
                const SizedBox(height: AppSize.s8),
                _buildListTile(
                    context,
                    AppLocalizations.of(context)!.translate('logout')!,
                    Icons.exit_to_app,
                    '',
                    Colors.red,
                    theme,
                    onTab: () {}),
              ],
            ),
            Text("${AppLocalizations.of(context)!.translate('version')!} 1.0.0",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: AppFontSize.s14,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      context, String title, IconData icon, String trailing, Color color, theme,
      {onTab}) {
    return ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.cD0),
        leading: Container(
          width: AppSize.s45,
          height: AppSize.s45,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color.withAlpha(AppSize.i30)),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: MokaBloc.get(context).state.isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
        trailing: SizedBox(
          width: AppSize.s130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(trailing,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600, fontSize: AppFontSize.s14)),
              const SizedBox(width: AppSize.s12),
              Icon(
                Icons.arrow_forward_ios,
                size: AppSize.s16,
                color: MokaBloc.get(context).state.isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ],
          ),
        ),
        onTap: onTab);
  }

  _showAppearanceModal(ThemeData theme, context) {
    bool current = MokaBloc.get(context).state.isDark;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSize.s26))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            height: AppSize.s300,
            decoration: BoxDecoration(
                color: MokaBloc.get(context).state.isDark
                    ? Colors.grey.shade900
                    : Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s26),
                  topRight: Radius.circular(AppSize.s26),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('select_theme')!,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: MokaBloc.get(context).state.isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                ListTile(
                  leading: const Icon(
                    Icons.brightness_5,
                    color: Colors.blue,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.translate('light_mode')!,
                      style: theme.textTheme.bodyLarge),
                  onTap: () {
                    MokaBloc.get(context).add(changeModeEvent(false));
                    Navigator.pop(context);
                  },
                  trailing: Icon(
                    Icons.check,
                    color: current == false ? Colors.green : Colors.transparent,
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                ListTile(
                  leading: const Icon(
                    Icons.brightness_2,
                    color: Colors.orange,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.translate('dark_mode')!,
                      style: theme.textTheme.bodyLarge),
                  onTap: () {
                    MokaBloc.get(context).add(changeModeEvent(true));
                    Navigator.pop(context);
                  },
                  trailing: Icon(
                    Icons.check,
                    color: current == true ? Colors.green : Colors.transparent,
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                ListTile(
                  leading: const Icon(
                    Icons.brightness_6,
                    color: Colors.blueGrey,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.translate('system_mode')!,
                      style: theme.textTheme.bodyLarge),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  _showAppearanceModalLang(ThemeData theme, context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSize.s26))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            height: AppSize.s240,
            decoration: BoxDecoration(
                color: MokaBloc.get(context).state.isDark
                    ? Colors.grey.shade900
                    : Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s26),
                  topRight: Radius.circular(AppSize.s26),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('select_language')!,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: MokaBloc.get(context).state.isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                ListTile(
                  leading: const Icon(
                    Icons.translate,
                    color: Colors.blue,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.translate('english')!,
                      style: theme.textTheme.bodyLarge),
                  onTap: () {
                    if (!AppLocalizations.of(context)!.isEnLocale) {
                      MokaBloc.get(context)
                          .add(changeLangEvent(AppConstants.englishCode));
                    }
                    Navigator.pop(context);
                  },
                  trailing: Icon(
                    Icons.check,
                    color: AppLocalizations.of(context)!.isEnLocale
                        ? Colors.green
                        : Colors.transparent,
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                ListTile(
                  leading: const Icon(
                    Icons.g_translate,
                    color: Colors.orange,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.translate('arabic')!,
                      style: theme.textTheme.bodyLarge),
                  onTap: () {
                    if (AppLocalizations.of(context)!.isEnLocale) {
                      MokaBloc.get(context)
                          .add(changeLangEvent(AppConstants.arabicCode));
                    }
                    Navigator.pop(context);
                  },
                  trailing: Icon(
                    Icons.check,
                    color: !AppLocalizations.of(context)!.isEnLocale
                        ? Colors.green
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
