import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/core/utils/font_manager.dart';
import 'package:moka_store/core/utils/routes_manager.dart';
import 'package:moka_store/core/utils/strings_manager.dart';
import 'package:moka_store/core/utils/values_manager.dart';
import 'package:readmore/readmore.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/shared/component.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../controller/moka_bloc.dart';
import 'favorite_icon_logic.dart';

String realPrice = '';
double realPriceN0Coma = 0;

class ItemDetailsScreen extends StatelessWidget {
  final item;

  const ItemDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    realPrice = (item.discount != '0') ? item.discount : item.price;
    realPriceN0Coma = double.parse(realPrice.replaceAll(',', ''));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        MokaBloc.get(context).add(
          SetNumberOfPieceEvent(),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: AppColor.white,
              child: Hero(
                tag: item.image,
                child: CachedNetworkImage(
                  imageUrl: '${item.image}',
                  width: double.infinity,
                  height: size.height * 0.4215,
                  errorWidget: (context, url, error) => Image.asset(
                    ImageAssets.onboardingLogo3,
                    height: AppSize.s150,
                    width: AppSize.s150,
                  ),
                  placeholder: (context, url) => Container(
                    color: AppColor.white,
                    width: double.infinity,
                    height: size.height * 0.46,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p26),
              child: Material(
                elevation: AppConstants.noElevation,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        MokaBloc.get(context).add(
                          SetNumberOfPieceEvent(),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: AppSize.s20,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: AppSize.s24,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.generalCartRoute);
                        MokaBloc.get(context).add(
                          SetNumberOfPieceEvent(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s35),
                      topRight: Radius.circular(AppSize.s35)),
                  color: Colors.transparent,
                ),
                height: size.height * 0.65,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppSize.s35),
                              topRight: Radius.circular(AppSize.s35)),
                        ),
                        height: size.height * 0.64 - AppSize.s30,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20),
                          child: SingleChildScrollView(
                            child: FadeInUp(
                              from: AppConstants.fadeInFrom,
                              duration: const Duration(
                                  milliseconds: AppConstants.fadeDelay),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: AppSize.s30,
                                  ),
                                  Text('${item.title}',
                                      maxLines: AppConstants.cI1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(fontSize: AppFontSize.s24)),
                                  const SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RatingBar.builder(
                                            itemSize: AppSize.s30,
                                            initialRating:
                                                double.parse(item.rate),
                                            ignoreGestures: true,
                                            minRating: AppConstants.cD1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: AppConstants.cI5,
                                            itemPadding:
                                                const EdgeInsetsDirectional
                                                    .only(
                                              end: AppPadding.p1,
                                            ),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: AppColor.primary,
                                              size: AppSize.s10,
                                            ),
                                            onRatingUpdate: (rating) {
                                              // print(rating);
                                            },
                                          ),
                                          const SizedBox(
                                            height: AppSize.s4,
                                          ),
                                          Text(
                                              '${item.rate} ${AppLocalizations.of(context)!.translate('ratings')!}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: AppColor.primary,
                                                    fontFamily: '',
                                                  ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text('${AppStrings.poundLE} ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              AppFontSize.s30,
                                                          fontFamily: '')),
                                              if (item.discount != "0")
                                                (item.discount == "12,000")
                                                    ? Text('12K ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge!
                                                            .copyWith(
                                                              fontSize:
                                                                  AppFontSize
                                                                      .s30,
                                                              fontFamily: '',
                                                            ))
                                                    : Text('${item.discount} ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge!
                                                            .copyWith(
                                                              fontSize:
                                                                  AppFontSize
                                                                      .s30,
                                                              fontFamily: '',
                                                            )),
                                              Text('${item.price}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .copyWith(
                                                          fontSize:
                                                              item.discount !=
                                                                      "0"
                                                                  ? AppFontSize
                                                                      .s15
                                                                  : AppFontSize
                                                                      .s30,
                                                          fontFamily: '',
                                                          decoration: item
                                                                      .discount !=
                                                                  "0"
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                          decorationColor:
                                                              AppColor
                                                                  .primary)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: AppSize.s2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: AppPadding.p24),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('per_piece')!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontFamily: '',
                                                    )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        AppLocalizations.of(context)!.isEnLocale
                                            ? AppSize.s16
                                            : AppSize.s0,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('description')!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s20,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  ReadMoreText(
                                    '${item.description}',
                                    trimLines: 3,
                                    colorClickableText: AppColor.primary,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText:
                                        AppLocalizations.of(context)!
                                            .translate('show_more')!,
                                    trimExpandedText:
                                        AppLocalizations.of(context)!
                                            .translate('show_less')!,
                                    moreStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s14,
                                          color: AppColor.primary,
                                        ),
                                    lessStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: AppFontSize.s14,
                                          color: AppColor.primary,
                                        ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: AppFontSize.s15),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s12,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('number_of_pieces')!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                fontSize: AppFontSize.s19,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: AppSize.s16,
                                        ),
                                        BlocBuilder<MokaBloc, MokaState>(
                                          buildWhen: (previous, current) =>
                                              previous.itemCount !=
                                              current.itemCount,
                                          builder: (context, state) {
                                            return Expanded(
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppSize
                                                                        .s30),
                                                        elevation:
                                                            AppConstants.cD10,
                                                        child: defaultButton(
                                                            function: () {
                                                              MokaBloc.get(
                                                                      context)
                                                                  .add(
                                                                const ChangeNumberOfPieceEvent(
                                                                    '-'),
                                                              );
                                                            },
                                                            text: '-',
                                                            width: AppSize.s20,
                                                            radius: AppSize.s30,
                                                            height:
                                                                AppSize.s30),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: AppSize.s5,
                                                    ),
                                                    Expanded(
                                                        child: OutlinedButton(
                                                      onPressed: () {},
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                            AppColor
                                                                .scaffoldLightBackGround,
                                                          ),
                                                          side:
                                                              MaterialStatePropertyAll(
                                                                  BorderSide(
                                                            color: AppColor
                                                                .primary,
                                                          )),
                                                          shape:
                                                              MaterialStatePropertyAll(
                                                            CircleBorder(
                                                              side:
                                                                  BorderSide(),
                                                            ),
                                                          ),
                                                          padding:
                                                              MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .all(
                                                            AppPadding.p8,
                                                          ))),
                                                      child: FittedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            bottom:
                                                                AppPadding.p1,
                                                          ),
                                                          child: Text(
                                                            '${state.itemCount}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                  color: AppColor
                                                                      .primary,
                                                                  fontFamily:
                                                                      '',
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      width: AppSize.s5,
                                                    ),
                                                    Expanded(
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppSize
                                                                        .s20),
                                                        elevation:
                                                            AppConstants.cD10,
                                                        child: defaultButton(
                                                            function: () {
                                                              MokaBloc.get(
                                                                      context)
                                                                  .add(
                                                                const ChangeNumberOfPieceEvent(
                                                                    '+'),
                                                              );
                                                            },
                                                            text: '+',
                                                            width: AppSize.s20,
                                                            radius: AppSize.s20,
                                                            height:
                                                                AppSize.s30),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ]),
                                  const SizedBox(
                                    height: AppSize.s16,
                                  ),
                                  buildMoreItem(
                                    context: context,
                                    //cubit: cubit ,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s35,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: AppPadding.p10, top: AppPadding.p4),
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(AppSize.s20),
                              bottomStart: Radius.circular(AppSize.s100),
                              topEnd: Radius.circular(AppSize.s100),
                              bottomEnd: Radius.circular(AppSize.s20)),
                          elevation: AppConstants.cD20,
                          child: InkWell(
                            onTap: () {
                              MokaBloc.get(context)
                                  .add(IsInFavoriteDatabaseEvent(item));
                            },
                            child: FavoriteIcon(
                              item: item,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMoreItem({
    required BuildContext context,
  }) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
              end: AppPadding.p20, start: AppPadding.p35),
          child: Material(
            elevation: AppSize.s30,
            borderRadius: BorderRadius.circular(AppSize.s30),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p60),
                child: Column(
                  children: [
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate('total_price')!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColor.primary),
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    BlocBuilder<MokaBloc, MokaState>(
                      buildWhen: (previous, current) =>
                          previous.itemCount != current.itemCount,
                      builder: (context, state) {
                        return Text(
                            '${AppStrings.poundLE} ${double.parse((realPriceN0Coma * state.itemCount).toStringAsFixed(2))}',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontFamily: ''));
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppPadding.p14),
                      child: Container(
                        width: double.infinity,
                        height: AppSize.s40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: AppColor.primary),
                          borderRadius: BorderRadius.circular(
                            AppSize.s30,
                          ),
                          color: AppColor.primary,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            MokaBloc.get(context).add(InsertToCartDatabaseEvent(
                              image: item.image,
                              name: item.title,
                              price: realPrice,
                              count: MokaBloc.get(context).state.itemCount,
                              context: context,
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_shopping_cart,
                                size: AppSize.s20,
                                color: AppColor.white,
                              ),
                              SizedBox(
                                width: AppSize.s20,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('add_to_cart')!,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: AppFontSize.s16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(AppSize.s50),
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: AppSize.s14,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: AppSize.s50,
            height: AppSize.s50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s50),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: AppColor.primary,
                size: AppSize.s24,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, Routes.generalCartRoute);
                MokaBloc.get(context).add(
                  SetNumberOfPieceEvent(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
