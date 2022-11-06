import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moka_store/core/utils/routes_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../home/category_items.dart';

class CategorySeeMoreScreen extends StatelessWidget {
  const CategorySeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('categories')!,
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(
            left: AppPadding.p16,
            right: AppPadding.p16,
            top: index == 0 ? AppPadding.p14 : AppPadding.p0,
            bottom: index == listCategory(context).length - 1
                ? AppPadding.p18
                : AppPadding.p0,
          ),
          child: FadeInUp(
            from: AppConstants.fadeInFrom,
            duration: const Duration(milliseconds: AppConstants.fadeDelay),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.categoryItemsRoute,
                  arguments: [
                    listCategory(context)[index].list,
                    listCategory(context)[index].name
                  ],
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: AppSize.s200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          listCategory(context)[index].image,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppPadding.p18,
                    left: AppPadding.p24,
                    child: Text(
                      listCategory(context)[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColor.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: AppSize.s12,
        ),
        itemCount: listCategory(context).length,
      ),
    );
  }
}
