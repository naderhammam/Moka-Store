import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moka_store/core/utils/strings_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/icons_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../components/products_items.dart';
import '../../controller/moka_bloc.dart';

class CategoryItemsScreen extends StatelessWidget {
  final item;
  final appbarTitle;

  const CategoryItemsScreen(
      {required this.appbarTitle, required this.item, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        print('create bloc');
        return sl<MokaBloc>()..add(setFilterProductEvent(item));
      },
      child: BlocBuilder<MokaBloc, MokaState>(
        buildWhen: (previous, current) =>
            previous.filterProduct != current.filterProduct ||
            previous.isOpenFilter != current.isOpenFilter,
        builder: (context, state) {
          print('object');
          return WillPopScope(
            onWillPop: () async {
              MokaBloc.get(context).add(closeFilterEvent());
              Navigator.pop(context);
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  appbarTitle,
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: AppSize.s8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.searchRoute,
                                  arguments: item,
                                );
                              },
                              child: Container(
                                height: AppSize.s50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12,
                                  vertical: AppPadding.p12,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s12),
                                    color: MokaBloc.get(context).state.isDark
                                        ? AppColor.scaffoldDarkBackGround
                                        : AppColor.scaffoldLightBackGround,
                                    border: Border.all(
                                      color: AppColor.grey,
                                    )),
                                child: Row(
                                  children: [
                                    Icon(IconBroken.Search,
                                        color: AppColor.grey),
                                    SizedBox(
                                      width: AppSize.s12,
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .translate('search')!,
                                        style: TextStyle(color: AppColor.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          GestureDetector(
                            onTap: () {
                              MokaBloc.get(context).add(openFilterEvent());
                            },
                            child: Container(
                              height: AppSize.s50,
                              width: AppSize.s50,
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(AppSize.s8),
                              ),
                              child: const Icon(
                                IconBroken.Filter,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (state.isOpenFilter)
                        SizedBox(
                          height: AppSize.s16,
                        ),
                      if (state.isOpenFilter)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s18, vertical: AppSize.s12),
                          decoration: BoxDecoration(
                            color: AppColor.menuDesign,
                            borderRadius: BorderRadius.circular(AppSize.s14),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.price,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      fontSize: AppFontSize.s18,
                                      color: AppColor.lightBlue,
                                    ),
                              ),
                              Slider(
                                value: 0,
                                min: 0,
                                max: 100,
                                divisions: 10,
                                label: '5',
                                onChanged: (value) {
                                  print(value);
                                },
                              ),
                              Text(
                                AppStrings.category,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      fontSize: AppFontSize.s18,
                                      color: AppColor.lightBlue,
                                    ),
                              ),
                              SizedBox(
                                height: AppSize.s8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.shirt,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s16,
                                        ),
                                  ),
                                  Spacer(),
                                  Checkbox(
                                    value: false,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {
                                      print(value);
                                    },
                                  ),
                                  SizedBox(
                                    width: AppSize.s8,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.tShirt,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s16,
                                        ),
                                  ),
                                  Spacer(),
                                  Checkbox(
                                    value: false,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {
                                      print(value);
                                    },
                                  ),
                                  SizedBox(
                                    width: AppSize.s8,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.pants,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s16,
                                        ),
                                  ),
                                  Spacer(),
                                  Checkbox(
                                    value: true,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {
                                      print(value);
                                    },
                                  ),
                                  SizedBox(
                                    width: AppSize.s8,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.shorts,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s16,
                                        ),
                                  ),
                                  Spacer(),
                                  Checkbox(
                                    value: false,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {
                                      print(value);
                                    },
                                  ),
                                  SizedBox(
                                    width: AppSize.s8,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        MokaBloc.get(context)
                                            .add(openFilterEvent());
                                      },
                                      child: Text(
                                        AppStrings.cancel,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: AppFontSize.s16,
                                              color: AppColor.lightBlue,
                                            ),
                                      )),
                                  SizedBox(
                                    width: AppSize.s20,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        print('object omkkkkkkkkk');
                                        MokaBloc.get(context).add(
                                            setFilterProductEvent(item
                                                .where((element) =>
                                                    element.category == 'pants')
                                                .toList()));
                                        MokaBloc.get(context)
                                            .add(openFilterEvent());
                                      },
                                      child: Text(
                                        AppStrings.ok,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: AppFontSize.s16,
                                              color: AppColor.lightBlue,
                                            ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppPadding.p18,
                          top: AppPadding.p24,
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSize.s16,
                            crossAxisSpacing: AppSize.s16,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) => ProductItems(
                            item: state.filterProduct[index],
                          ),
                          itemCount: state.filterProduct.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
