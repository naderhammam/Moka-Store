import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:moka_store/core/utils/assets_manager.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/core/utils/icons_manager.dart';
import 'package:moka_store/core/utils/strings_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/color_manager.dart';
import '../../controller/moka_bloc.dart';
import 'list_icons.dart';

final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

class MainHomeZoom extends StatelessWidget {
  const MainHomeZoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuScreen: const MenuScreen(),
      mainScreen: const MainScreen(),
      borderRadius: AppSize.s24,
      menuBackgroundColor: AppColor.primary,
      style: DrawerStyle.defaultStyle,
      duration: const Duration(milliseconds: AppConstants.zoomDelay),
      openCurve: Curves.fastOutSlowIn,
      showShadow: true,
      angle: -AppSize.s12,
      mainScreenTapClose: true,
      isRtl: AppLocalizations.of(context)!.isEnLocale ? false : true,
      drawerShadowsBackgroundColor: Colors.grey[300]!,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<MokaBloc, MokaState>(
      buildWhen: (previous, current) =>
          previous.currentIndexNavigation != current.currentIndexNavigation ||
          previous.isDark != current.isDark,
      builder: (context, state) {
        var bloc = MokaBloc.get(context);
        log('main Bloccccccccc');
        return WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s18)),
                    actionsPadding: EdgeInsetsDirectional.only(
                      bottom: AppPadding.p10,
                    ),
                    title: Text(AppStrings.areYouSure,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: AppColor.primary,
                                )),
                    content: Text(AppStrings.doYouExit,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: AppSize.s16,
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
                            return Navigator.of(context).pop(true);
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
                            return Navigator.of(context).pop(false);
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
            if (value != null) {
              return Future.value(value);
            } else {
              return Future.value(false);
            }
          },
          child: Scaffold(
            appBar: AppBar(
                title:
                    Text(AppLocalizations.of(context)!.translate('app_name')!),
                leading: InkWell(
                  onTap: () {
                    zoomDrawerController.toggle!();
                  },
                  splashColor: AppColor.transparent,
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p16, right: AppPadding.p14),
                    child: SvgPicture.asset(
                      ImageAssets.menu,
                      color: MokaBloc.get(context).state.isDark
                          ? AppColor.white
                          : AppColor.black,
                    ),
                  ),
                )),
            body: state.screens![state.currentIndexNavigation!],
            bottomNavigationBar: SizedBox(
                height: size.width * .155,
                child: ListView.builder(
                  itemCount: AppConstants.cI4,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: size.width * .024),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      bloc.add(ChangeIndexEvent(index));
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: size.width * .014),
                        Icon(
                          listOfIcons[index],
                          size: size.width * .076,
                          color: index == state.currentIndexNavigation
                              ? AppColor.primary
                              : Colors.white,
                        ),
                        AnimatedContainer(
                          duration: const Duration(
                              milliseconds: AppConstants.containerDelay),
                          curve: Curves.fastLinearToSlowEaseIn,
                          margin: EdgeInsets.only(
                            top: index == state.currentIndexNavigation
                                ? 0
                                : size.width * .029,
                            right: size.width * .0422,
                            left: size.width * .0422,
                          ),
                          width: size.width * .153,
                          height: index == state.currentIndexNavigation
                              ? size.width * .014
                              : 0,
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppSize.s20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p24),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      MokaBloc.get(context)
                          .add(const ChangeIndexEvent(AppConstants.cI3));
                      zoomDrawerController.close!();
                    },
                    splashColor: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Profile),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate('profile')!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppPadding.p24,
                  ),
                  InkWell(
                    onTap: () async {
                      MokaBloc.get(context)
                          .add(const ChangeIndexEvent(AppConstants.cI1));
                      zoomDrawerController.close!();
                    },
                    splashColor: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Heart),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('favorites')!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppPadding.p24,
                  ),
                  InkWell(
                    onTap: () {
                      MokaBloc.get(context)
                          .add(const ChangeIndexEvent(AppConstants.cI2));
                      zoomDrawerController.close!();
                    },
                    splashColor: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Wallet),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate('orders')!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppPadding.p24,
                  ),
                  InkWell(
                    onTap: () {},
                    splashColor: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Calling),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('delivery')!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppPadding.p24,
                  ),
                  InkWell(
                    onTap: () {
                      MokaBloc.get(context)
                          .add(const ChangeIndexEvent(AppConstants.cI3));
                      zoomDrawerController.close!();
                    },
                    splashColor: AppColor.lightGrey,
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Setting),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('settings')!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppPadding.p24,
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                child: const Icon(
                  Icons.circle,
                  color: AppColor.menuDesign,
                  size: AppSize.s140,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.65,
                left: MediaQuery.of(context).size.width * 0.35,
                child: const Icon(
                  Icons.circle_outlined,
                  color: AppColor.menuDesign,
                  size: AppSize.s40,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.38,
                child: const Icon(
                  Icons.circle_outlined,
                  color: AppColor.menuDesign,
                  size: AppSize.s30,
                ),
              ),
              Positioned(
                top: -35,
                left: MediaQuery.of(context).size.width * 0.1,
                child: const Icon(
                  Icons.circle,
                  color: AppColor.menuDesign,
                  size: AppSize.s80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
