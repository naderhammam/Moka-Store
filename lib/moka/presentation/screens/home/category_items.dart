import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moka_store/core/utils/color_manager.dart';
import 'package:moka_store/core/utils/routes_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/shared/constant.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../controller/moka_bloc.dart';

class CarouselSliderItem extends StatelessWidget {
  const CarouselSliderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MokaBloc, MokaState>(
      buildWhen: (previous, current) =>
          previous.electronicsProduct != current.electronicsProduct,
      builder: (context, state) {
        print('build CarouselSliderItem');
        return CarouselSlider(
            items: listCategory(context).map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.categoryItemsRoute,
                    arguments: [e.list, e.name],
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            e.image,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: AppPadding.p18,
                      left: AppPadding.p24,
                      child: Text(
                        e.name,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: AppColor.white),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: AppSize.s200,
              viewportFraction: AppConstants.cD1,
              initialPage: AppConstants.cI0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval:
                  const Duration(seconds: AppConstants.playInterval),
              autoPlayAnimationDuration:
                  const Duration(milliseconds: AppConstants.playAnimation),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ));
      },
    );
  }
}

class ComponentCategories extends Equatable {
  final String image;
  final String name;
  final List list;

  const ComponentCategories(
      {required this.image, required this.name, required this.list});

  @override
  List<Object> get props => [image, name, list];
}

List<ComponentCategories> listCategory(context) => [
      ComponentCategories(
        image: AppStrings.categoryImage3,
        name: AppLocalizations.of(context)!.translate('electronics')!,
        list: electronicsProductConstant!,
      ),
      ComponentCategories(
        image: AppStrings.categoryImage1,
        name: AppLocalizations.of(context)!.translate('men')!,
        list: menProductConstant!,
      ),
      ComponentCategories(
        image: AppStrings.categoryImage2,
        name: AppLocalizations.of(context)!.translate('women')!,
        list: womenProductConstant!,
      ),
      ComponentCategories(
        image: AppStrings.categoryImage4,
        name: AppLocalizations.of(context)!.translate('watches')!,
        list: watchesProductConstant!,
      ),
      ComponentCategories(
        image: AppStrings.categoryImage5,
        name: AppLocalizations.of(context)!.translate('supermarket')!,
        list: supermarketProductConstant!,
      ),
    ];
