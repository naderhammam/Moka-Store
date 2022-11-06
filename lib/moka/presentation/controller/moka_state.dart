part of 'moka_bloc.dart';

class MokaState extends Equatable {
  final int? currentIndexNavigation;
  final int? currentIndexItem;
  final int? menuRefresh;
  final List<ProductSelectedState>? compare1;
  final List<Widget>? screens;
  final ProductSelectedState? itemSelected;

  final List<ItemDetails> electronicsProduct;
  final List<ItemDetails> supermarketProduct;
  final List<ItemDetails> menProduct;
  final List<ItemDetails> womenProduct;
  final List<ItemDetails> watchesProduct;
  final List<ItemDetails> currentProduct;
  final List<ItemDetails> allProduct;

  final RequestState electronicsProductState;
  final RequestState currentProductState;
  final RequestState supermarketProductState;
  final RequestState menProductState;
  final RequestState womenProductState;
  final RequestState watchesProductState;
  final RequestState allProductState;

  final Database? database;
  final List<Map>? cartItems;
  final List<Map>? favoritesItems;
  final double totalPrice;
  final int itemCount;
  final RequestState cartState;

  final bool isDark;
  final Locale locale;
  final List<ItemDetails> filterProduct;
  final bool isOpenFilter;

  const MokaState({
    this.cartItems = const [],
    this.favoritesItems = const [],
    this.database,
    this.totalPrice = 0,
    this.itemCount = 1,
    this.electronicsProduct = const [],
    this.currentProduct = const [],
    this.supermarketProduct = const [],
    this.menProduct = const [],
    this.womenProduct = const [],
    this.watchesProduct = const [],
    this.allProduct = const [],
    this.isOpenFilter = false,
    this.electronicsProductState = RequestState.loading,
    this.currentProductState = RequestState.loading,
    this.supermarketProductState = RequestState.loading,
    this.menProductState = RequestState.loading,
    this.womenProductState = RequestState.loading,
    this.watchesProductState = RequestState.loading,
    this.allProductState = RequestState.loading,
    this.cartState = RequestState.error,
    this.currentIndexItem = 0,
    this.currentIndexNavigation = 0,
    this.menuRefresh = 0,
    this.filterProduct = const [],
    this.isDark = false,
    this.locale = const Locale(AppConstants.englishCode),
    this.screens = const [
      HomeScreen(),
      FavoritesScreen(),
      CartsScreen(),
      SettingsScreen()
    ],
    this.itemSelected = ProductSelectedState.men,
    this.compare1 = const [
      ProductSelectedState.electric,
      ProductSelectedState.men,
      ProductSelectedState.women,
      ProductSelectedState.watch,
      ProductSelectedState.supermarket
    ],
  });

  MokaState copyWith({
    Database? database,
    List<Map>? cartItems,
    List<Map>? favoritesItems,
    double? totalPrice,
    int? itemCount,
    bool? isOpenFilter,
    List<ItemDetails>? electronicsProduct,
    List<ItemDetails>? currentProduct,
    List<ItemDetails>? supermarketProduct,
    List<ItemDetails>? menProduct,
    List<ItemDetails>? womenProduct,
    List<ItemDetails>? watchesProduct,
    List<ItemDetails>? allProduct,
    RequestState? electronicsProductState,
    RequestState? currentProductState,
    RequestState? supermarketProductState,
    RequestState? menProductState,
    RequestState? womenProductState,
    RequestState? watchesProductState,
    RequestState? allProductState,
    RequestState? cartState,
    int? currentIndexNavigation,
    itemSelected,
    int? currentIndexItem,
    bool? isDark,
    Locale? locale,
    List<ItemDetails>? filterProduct,
  }) {
    return MokaState(
      cartItems: cartItems ?? this.cartItems,
      favoritesItems: favoritesItems ?? this.favoritesItems,
      database: database ?? this.database,
      totalPrice: totalPrice ?? this.totalPrice,
      itemCount: itemCount ?? this.itemCount,
      currentIndexNavigation:
          currentIndexNavigation ?? this.currentIndexNavigation,
      itemSelected: itemSelected ?? this.itemSelected,
      currentIndexItem: currentIndexItem ?? this.currentIndexItem,
      electronicsProduct: electronicsProduct ?? this.electronicsProduct,
      electronicsProductState:
          electronicsProductState ?? this.electronicsProductState,
      currentProduct: currentProduct ?? this.currentProduct,
      currentProductState: currentProductState ?? this.currentProductState,
      supermarketProduct: supermarketProduct ?? this.supermarketProduct,
      supermarketProductState:
          supermarketProductState ?? this.supermarketProductState,
      menProduct: menProduct ?? this.menProduct,
      menProductState: menProductState ?? this.menProductState,
      womenProduct: womenProduct ?? this.womenProduct,
      womenProductState: womenProductState ?? this.womenProductState,
      watchesProduct: watchesProduct ?? this.watchesProduct,
      watchesProductState: watchesProductState ?? this.watchesProductState,
      cartState: cartState ?? this.cartState,
      allProduct: allProduct ?? this.allProduct,
      allProductState: allProductState ?? this.allProductState,
      isDark: isDark ?? this.isDark,
      locale: locale ?? this.locale,
      filterProduct: filterProduct ?? this.filterProduct,
      isOpenFilter: isOpenFilter ?? this.isOpenFilter,
    );
  }

  @override
  List<Object?> get props => [
        cartItems,
        favoritesItems,
        database,
        totalPrice,
        itemCount,
        currentIndexNavigation,
        currentIndexItem,
        menuRefresh,
        compare1,
        screens,
        itemSelected,
        electronicsProduct,
        supermarketProduct,
        menProduct,
        womenProduct,
        watchesProduct,
        currentProduct,
        electronicsProductState,
        currentProductState,
        supermarketProductState,
        menProductState,
        womenProductState,
        watchesProductState,
        cartState,
        allProduct,
        allProductState,
        isDark,
        locale,
        filterProduct,
        isOpenFilter,
      ];
}
