import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/assets_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/icons_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../controller/moka_bloc.dart';

var searchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  final listSearch;

  const SearchScreen({required this.listSearch, Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dynamic listSearch;
  bool isNotFound = false;
  bool isLoading = true;
  String? search;
  List<dynamic> liftList = [];
  List<dynamic> rightList = [];

  @override
  void initState() {
    listSearch = [];
    super.initState();
  }

  void searchFilter(String value) {
    dynamic result;
    if (value.isEmpty) {
      result = [];
    } else {
      result = widget.listSearch
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()) as bool)
          .toList();
    }
    setState(() {
      search = value;
      if (value == '') {
        listSearch = result;
        liftList = result;
        rightList = result;
        isNotFound = false;
        isLoading = true;
      } else if (result.isEmpty) {
        listSearch = result;
        liftList = result;
        rightList = result;
        isNotFound = true;
        isLoading = false;
      } else {
        listSearch = result;
        liftList = [];
        rightList = [];
        for (int i = 0; i < listSearch.length; i = i + 2) {
          liftList.add(listSearch[i]);
        }
        for (int i = 1; i < listSearch.length; i = i + 2) {
          rightList.add(listSearch[i]);
        }
        isNotFound = false;
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchController.clear();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s60,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          searchController.clear();
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: MokaBloc.get(context).state.isDark
                              ? AppColor.white
                              : AppColor.black,
                        )),
                    const SizedBox(
                      width: AppSize.s16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {},
                        textDirection: (search == null || search == '')
                            ? TextDirection.ltr
                            : (search!.contains(RegExp(r'[أ-ي]')))
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        onChanged: (value) => searchFilter(value),
                        cursorColor: AppColor.primary,
                        style: TextStyle(
                          color: MokaBloc.get(context).state.isDark
                              ? AppColor.white
                              : AppColor.black,
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .translate('search')!,
                          hintStyle: const TextStyle(
                            color: AppColor.grey,
                            fontSize: AppFontSize.s16,
                          ),
                          prefixIcon: const Icon(
                            IconBroken.Search,
                            color: AppColor.grey,
                          ),
                          filled: true,
                          fillColor: MokaBloc.get(context).state.isDark
                              ? AppColor.scaffoldDarkBackGround
                              : AppColor.scaffoldLightBackGround,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSize.s10,
                            vertical: AppSize.s16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s30),
                            borderSide: const BorderSide(
                              color: AppColor.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s30),
                            borderSide: const BorderSide(
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s24,
                ),
                if (isLoading)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      Text(
                          AppLocalizations.of(context)!
                              .translate('what_are_you_looking_for')!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: AppColor.grey,
                                fontSize: AppFontSize.s20,
                              )),
                      const SizedBox(
                        height: AppSize.s70,
                      ),
                      Image.asset(
                        ImageAssets.firstSearch,
                        height: AppSize.s250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                (isNotFound)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.translate('results_for')!} “$search”',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontSize: AppFontSize.s16,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                    '${AppLocalizations.of(context)!.translate('found')!} 0',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s40,
                          ),
                          Image.asset(ImageAssets.noSearch,
                              height: AppSize.s250,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover),
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('item_not_found')!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontSize: AppFontSize.s18,
                                  )),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context)!
                                .translate('basic_not_found')!,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: AppFontSize.s14,
                                      color: AppColor.grey,
                                    ),
                          ),
                        ],
                      )
                    : buildSearchItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem() {
    return Column(
      children: [
        if (listSearch.length > 0)
          Text(
            '${AppLocalizations.of(context)!.translate('found')!} ${listSearch.length} ${AppLocalizations.of(context)!.translate('results')!}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(children: [
                ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.itemDetailsRoute,
                            arguments: liftList[index]);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: AppSize.s60,
                              ),
                              Container(
                                height: AppSize.s230,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10),
                                  color: MokaBloc.get(context).state.isDark
                                      ? AppColor.blueBlack
                                      : AppColor.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        liftList[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontSize: AppFontSize.s18),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: AppSize.s8,
                                      ),
                                      Text(
                                        "${liftList[index].price} ${AppStrings.poundLE}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: AppFontSize.s18,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            child: Hero(
                              tag: liftList[index].image,
                              child: CachedNetworkImage(
                                height: AppSize.s140,
                                width: AppSize.s140,
                                fit: BoxFit.fill,
                                imageUrl: '${liftList[index].image}',
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  ImageAssets.onboardingLogo3,
                                  height: AppSize.s150,
                                  width: AppSize.s150,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: AppSize.s18,
                    );
                  },
                  itemCount: liftList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ]),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: Column(children: [
                const SizedBox(
                  height: AppSize.s70,
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.itemDetailsRoute,
                            arguments: rightList[index]);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: AppSize.s60,
                              ),
                              Container(
                                height: AppSize.s230,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10),
                                  color: MokaBloc.get(context).state.isDark
                                      ? AppColor.blueBlack
                                      : AppColor.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        rightList[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontSize: AppFontSize.s18),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: AppSize.s8,
                                      ),
                                      Text(
                                        "${rightList[index].price} ${AppStrings.poundLE}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: AppFontSize.s18,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            child: Hero(
                              tag: rightList[index].image,
                              child: CachedNetworkImage(
                                height: AppSize.s140,
                                width: AppSize.s140,
                                fit: BoxFit.fill,
                                imageUrl: '${rightList[index].image}',
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  ImageAssets.onboardingLogo3,
                                  height: AppSize.s150,
                                  width: AppSize.s150,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: AppSize.s18,
                    );
                  },
                  itemCount: rightList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
