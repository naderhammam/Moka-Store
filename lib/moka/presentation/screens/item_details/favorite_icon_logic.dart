import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moka_store/core/utils/values_manager.dart';

import '../../../../core/utils/color_manager.dart';
import '../../controller/moka_bloc.dart';

class FavoriteIcon extends StatelessWidget {
  final item;

  const FavoriteIcon({this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MokaBloc, MokaState>(
      buildWhen: (previous, current) =>
          previous.favoritesItems != current.favoritesItems,
      builder: (context, state) {
        bool isInFavorite = false;
        for (var element in state.favoritesItems as List<Map>) {
          if (element['name'] == item.title) {
            isInFavorite = true;
            break;
          }
        }
        return Container(
          width: AppSize.s70,
          height: AppSize.s70,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Icon(
            Icons.favorite,
            color: (isInFavorite) ? AppColor.primary : AppColor.grey,
            size: AppSize.s30,
          ),
        );
      },
    );
  }
}
