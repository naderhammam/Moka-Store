import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moka_store/core/utils/assets_manager.dart';

import '../../../core/utils/color_manager.dart';
import '../../../core/utils/constants_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../../../core/utils/strings_manager.dart';
import '../../../core/utils/values_manager.dart';
import '../controller/moka_bloc.dart';

class ProductItems extends StatelessWidget {
  final item;

  const ProductItems({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.itemDetailsRoute,
          arguments: item,
        );
      },
      child: Stack(
        children: [
          Container(
            height: AppSize.s260,
            width: AppSize.s200,
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8, vertical: AppPadding.p12),
            decoration: BoxDecoration(
              color: MokaBloc.get(context).state.isDark
                  ? AppColor.scaffoldDarkBackGround
                  : AppColor.scaffoldLightBackGround,
              borderRadius: BorderRadius.circular(AppSize.s12),
              border: Border.all(
                color: AppColor.lightPrimary,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  child: Hero(
                    tag: item.image,
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                      height: AppSize.s150,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Image.asset(
                        ImageAssets.onboardingLogo3,
                        height: AppSize.s150,
                        width: AppSize.s150,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: AppConstants.cI1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                (item.discount != "0")
                    ? Text(
                        '${AppStrings.poundLE} ${item.discount}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : Text(
                        '${AppStrings.poundLE} ${item.price}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                RatingBar.builder(
                  itemSize: AppSize.s20,
                  initialRating: double.parse(item.rate),
                  ignoreGestures: true,
                  minRating: AppConstants.cD1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: AppConstants.cI5,
                  itemPadding: const EdgeInsetsDirectional.only(
                    end: AppPadding.p1,
                  ),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColor.primary,
                    size: AppSize.s10,
                  ),
                  onRatingUpdate: (rating) {
                    // print(rating);
                  },
                ),
              ],
            ),
          ),
          if (item.discount != "0")
            Positioned(
                bottom: AppSize.s100,
                right: AppPadding.p6,
                child: SvgPicture.asset(
                  ImageAssets.discountIcon,
                  height: AppSize.s26,
                  width: AppSize.s26,
                )),
        ],
      ),
    );
  }
}
