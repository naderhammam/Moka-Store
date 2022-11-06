import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/enums_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../components/products_items.dart';
import '../../controller/moka_bloc.dart';
import 'category_items.dart';

List<ProductSelectedState> compare2 = [
  ProductSelectedState.electric,
  ProductSelectedState.men,
  ProductSelectedState.women,
  ProductSelectedState.watch,
  ProductSelectedState.supermarket,
];

class ProductPart extends StatelessWidget {
  const ProductPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MokaBloc, MokaState>(
      buildWhen: (previous, current) =>
          previous.currentIndexItem != current.currentIndexItem ||
          previous.currentProduct != current.currentProduct,
      builder: (context, state) {
        var bloc = MokaBloc.get(context);
        print('Home Bloccccccccc');

        switch (state.currentProductState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s310,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return Column(
              children: [
                SizedBox(
                  height: AppSize.s50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          bloc.add(IsSelectedItemProductsEvent(index));
                        },
                        child: AnimatedContainer(
                          width: AppSize.s140,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s30),
                            border: Border.all(
                              color:
                                  (state.compare1![state.currentIndexItem!] ==
                                          compare2[index])
                                      ? AppColor.primary
                                      : AppColor.lightGrey,
                              width: AppSize.s2,
                            ),
                          ),
                          duration: const Duration(
                              milliseconds: AppConstants.containerAnimation),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                listCategory(context)[index].name,
                                style: TextStyle(
                                  color: (state.compare1![
                                              state.currentIndexItem!] ==
                                          compare2[index])
                                      ? AppColor.primary
                                      : AppColor.lightGrey,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                    itemCount: 5,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  height: AppSize.s260,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ProductItems(
                        item: state.currentProduct[index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: AppSize.s14,
                    ),
                    itemCount: state.currentProduct.length,
                  ),
                ),
              ],
            );
          case RequestState.error:
            return const Center(
              child: Text('Error'),
            );
        }
      },
    );
  }
}
