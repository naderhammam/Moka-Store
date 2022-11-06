import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moka_store/config/helper/cache_helper.dart';
import 'package:moka_store/core/network/api_constance.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/moka/domain/entities/item_details.dart';
import 'package:moka_store/moka/domain/use_cases/change_lang_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_all_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_electronics_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_final_token_card_visa_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_final_token_kiosk_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_order_id_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_reference_code_use_case.dart';
import 'package:moka_store/moka/presentation/screens/carts/carts_screen.dart';
import 'package:moka_store/moka/presentation/screens/favorites/favorites_screen.dart';
import 'package:moka_store/moka/presentation/screens/home/home_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../../../config/locale/app_localizations.dart';
import '../../../config/shared/constant.dart';
import '../../../core/utils/enums_manager.dart';
import '../../domain/use_cases/get_first_token_use_case.dart';
import '../../domain/use_cases/get_men_use_case.dart';
import '../../domain/use_cases/get_saved_lang_use_case.dart';
import '../../domain/use_cases/get_supermarket_use_case.dart';
import '../../domain/use_cases/get_watches_use_case.dart';
import '../../domain/use_cases/get_women_use_case.dart';
import '../screens/settings/settings_screen.dart';

part 'moka_event.dart';
part 'moka_state.dart';

class MokaBloc extends Bloc<MokaEvent, MokaState> {
  final GetElectronicsProductUseCase getElectronicsProductUseCase;
  final GetSupermarketProductUseCase getSupermarketProductUseCase;
  final GetMenProductUseCase getMenProductUseCase;
  final GetWomenProductUseCase getWomenProductUseCase;
  final GetWatchesProductUseCase getWatchesProductUseCase;
  final GetAllProductUseCase getAllProductUseCase;
  final GetFirstTokenUseCase getFirstTokenUseCase;
  final GetOrderIdUseCase getOrderIdUseCase;
  final GetFinalTokenCardVisaUseCase getFinalTokenCardVisaUseCase;
  final GetFinalTokenKioskUseCase getFinalTokenKioskUseCase;
  final GetReferenceCodeUseCase getReferenceCodeUseCase;
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  static MokaBloc get(context) => BlocProvider.of(context);

  MokaBloc(
    this.getWomenProductUseCase,
    this.getWatchesProductUseCase,
    this.getAllProductUseCase,
    this.getMenProductUseCase,
    this.getSupermarketProductUseCase,
    this.getElectronicsProductUseCase,
    this.getFirstTokenUseCase,
    this.getOrderIdUseCase,
    this.getFinalTokenCardVisaUseCase,
    this.getFinalTokenKioskUseCase,
    this.getReferenceCodeUseCase,
    this.getSavedLangUseCase,
    this.changeLangUseCase,
  ) : super(const MokaState()) {
    on<ChangeIndexEvent>(_changeIndexNavigationBar);
    on<IsSelectedItemProductsEvent>(_isSelected);
    on<GetElectronicsProductEvent>(_getElectronicsProduct);
    on<GetSupermarketProductEvent>(_getSupermarketProduct);
    on<GetMenProductEvent>(_getMenProduct);
    on<GetWomenProductEvent>(_getWomenProduct);
    on<GetWatchesProductEvent>(_getWatchesProduct);
    on<GetAllProductEvent>(_getAllProduct);
    on<CreateDataBaseEvent>(_createDataBase);
    on<InsertToCartDatabaseEvent>(_insertToDatabase);
    on<InsertToFavoritesDatabaseEvent>(_insertToFavoritesDatabase);
    on<GetFromCartDatabaseEvent>(_getFromDatabase);
    on<GetFromFavoriteDatabaseEvent>(_getFromFavoritesDatabase);
    on<DeleteFromCartDatabaseEvent>(_deleteFromDatabase);
    on<DeleteFromFavoriteDatabaseEvent>(_deleteFromFavoritesDatabase);
    on<UpdateFromCartDatabaseEvent>(_updateFromDatabase);
    on<ChangeNumberOfPieceEvent>(_changeNumberOfPiece);
    on<SetNumberOfPieceEvent>(_setNumberOfPiece);
    on<IsInFavoriteDatabaseEvent>(_isInFavoriteDatabase);
    on<getFirstTokenEvent>(_getFirstToken);
    on<getOrderIdEvent>(_getOrderId);
    on<getFinalTokenCardVisaEvent>(_getFinalTokenCardVisa);
    on<getFinalTokenKioskEvent>(_getFinalTokenKiosk);
    on<getReferenceCodeEvent>(_getReferenceCode);
    on<changeModeEvent>(_changeMode);
    on<changeLangEvent>(_changeLang);
    on<getSavedLangEvent>(_getSavedLang);
    on<setFilterProductEvent>(_setFilterProduct);
    on<openFilterEvent>(_openFilter);
    on<closeFilterEvent>(_closeFilter);
  }

  FutureOr<void> _isSelected(
      IsSelectedItemProductsEvent event, Emitter<MokaState> emit) {
    List<ItemDetails> nowProduct = [];
    if (event.index == 0) nowProduct = state.electronicsProduct;
    if (event.index == 1) nowProduct = state.menProduct;
    if (event.index == 2) nowProduct = state.womenProduct;
    if (event.index == 3) nowProduct = state.watchesProduct;
    if (event.index == 4) nowProduct = state.supermarketProduct;

    emit(state.copyWith(
      currentIndexItem: event.index,
      currentProduct: nowProduct,
    ));
  }

  FutureOr<void> _changeIndexNavigationBar(
      ChangeIndexEvent event, Emitter<MokaState> emit) {
    emit(state.copyWith(
      currentIndexNavigation: event.index,
    ));
  }

  FutureOr<void> _getElectronicsProduct(
      GetElectronicsProductEvent event, Emitter<MokaState> emit) async {
    final result = await getElectronicsProductUseCase();
    electronicsProductConstant = result;
    emit(state.copyWith(
      electronicsProduct: result,
      currentProduct: result,
      electronicsProductState: RequestState.loaded,
      currentProductState: RequestState.loaded,
    ));
  }

  FutureOr<void> _getSupermarketProduct(
      GetSupermarketProductEvent event, Emitter<MokaState> emit) async {
    final result = await getSupermarketProductUseCase();
    supermarketProductConstant = result;
    emit(state.copyWith(
      supermarketProduct: result,
      supermarketProductState: RequestState.loaded,
    ));
  }

  FutureOr<void> _getWatchesProduct(
      GetWatchesProductEvent event, Emitter<MokaState> emit) async {
    final result = await getWatchesProductUseCase();
    watchesProductConstant = result;
    emit(state.copyWith(
      watchesProduct: result,
      watchesProductState: RequestState.loaded,
    ));
  }

  FutureOr<void> _getMenProduct(
      GetMenProductEvent event, Emitter<MokaState> emit) async {
    final result = await getMenProductUseCase();
    menProductConstant = result;
    emit(state.copyWith(
      menProduct: result,
      menProductState: RequestState.loaded,
    ));
  }

  FutureOr<void> _getWomenProduct(
      GetWomenProductEvent event, Emitter<MokaState> emit) async {
    final result = await getWomenProductUseCase();
    womenProductConstant = result;
    emit(state.copyWith(
      womenProduct: result,
      womenProductState: RequestState.loaded,
    ));
  }

  FutureOr<void> _getAllProduct(
      GetAllProductEvent event, Emitter<MokaState> emit) async {
    final result = await getAllProductUseCase();
    allProductConstant = result;
    emit(state.copyWith(
      allProductState: RequestState.loaded,
      allProduct: result,
    ));
  }

  FutureOr<void> _createDataBase(
      CreateDataBaseEvent event, Emitter<MokaState> emit) async {
    print('DataBase Created !');

    await openDatabase('moka1.db', version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE carts (id INTEGER PRIMARY KEY, name TEXT, price TEXT, image TEXT, quantity INTEGER)',
      );
      await db.execute(
        'CREATE TABLE favorites (id INTEGER PRIMARY KEY, name TEXT, price TEXT, image TEXT, rate TEXT)',
      );
    }, onOpen: (db) {
      add(GetFromCartDatabaseEvent());
      add(GetFromFavoriteDatabaseEvent());
      emit(state.copyWith(
        database: db,
      ));
      print('DataBase Opened !');
    });
  }

  FutureOr<void> _insertToDatabase(
      InsertToCartDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    await database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO carts(name, price, image, quantity) VALUES(?, ?, ?, ?)',
          [
            event.name,
            event.price,
            event.image,
            event.count,
          ]);
      add(GetFromCartDatabaseEvent());
      Fluttertoast.showToast(
        msg: AppLocalizations.of(event.context)!.translate('add_success')!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('inserted1: $id1');
    });
  }

  FutureOr<void> _getFromDatabase(
      GetFromCartDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    List<Map> cartItems = [];
    double totalPrice = 0;
    double filterPrice = 0;
    if (database != null) {
      await database.rawQuery('SELECT * FROM carts').then((value) {
        for (var element in value) {
          cartItems.add(element);
          filterPrice =
              double.parse(element['price'].toString().replaceAll(',', ''));
          totalPrice +=
              filterPrice * double.parse(element['quantity'].toString());
        }
        print('success get from database');
        cartConstant = cartItems;
        emit(state.copyWith(
          cartItems: cartItems,
          // filter total price from digits
          totalPrice: double.parse(totalPrice.toStringAsFixed(2)),
        ));
      });
    }
  }

  FutureOr<void> _deleteFromDatabase(
      DeleteFromCartDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    await database!.transaction((txn) async {
      int id1 =
          await txn.rawDelete('DELETE FROM carts WHERE id = ?', [event.id]);
      add(GetFromCartDatabaseEvent());
      print('deleted1: $id1');
    });
  }

  FutureOr<void> _updateFromDatabase(
      UpdateFromCartDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    await database!.transaction((txn) async {
      int id1 =
          await txn.rawUpdate('UPDATE carts SET quantity = ? WHERE id = ?', [
        event.count,
        event.id,
      ]);
      add(GetFromCartDatabaseEvent());
      print('updated1: $id1');
    });
  }

  FutureOr<void> _changeNumberOfPiece(
      ChangeNumberOfPieceEvent event, Emitter<MokaState> emit) {
    if (event.typeOfChange == '-') {
      if (state.itemCount > 1) {
        emit(state.copyWith(
          itemCount: state.itemCount - 1,
        ));
      }
    } else {
      emit(state.copyWith(
        itemCount: state.itemCount + 1,
      ));
    }
  }

  FutureOr<void> _setNumberOfPiece(
      SetNumberOfPieceEvent event, Emitter<MokaState> emit) {
    emit(state.copyWith(
      itemCount: 1,
    ));
  }

  FutureOr<void> _insertToFavoritesDatabase(
      InsertToFavoritesDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    await database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO favorites(name, price, image, rate) VALUES(?, ?, ?, ?)',
          [
            event.itemDetails.title,
            (event.itemDetails.discount != '0')
                ? event.itemDetails.discount
                : event.itemDetails.price,
            event.itemDetails.image,
            event.itemDetails.rate,
          ]);
      add(GetFromFavoriteDatabaseEvent());

      print('inserted1: $id1');
    });
  }

  FutureOr<void> _getFromFavoritesDatabase(
      GetFromFavoriteDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    List<Map> favoritesItems = [];
    if (database != null) {
      await database.rawQuery('SELECT * FROM favorites').then((value) {
        for (var element in value) {
          favoritesItems.add(element);
        }
        print('success get from database');
        emit(state.copyWith(
          favoritesItems: favoritesItems,
        ));
      });
    }
  }

  FutureOr<void> _deleteFromFavoritesDatabase(
      DeleteFromFavoriteDatabaseEvent event, Emitter<MokaState> emit) async {
    final database = state.database;
    await database!.transaction((txn) async {
      int id1 =
          await txn.rawDelete('DELETE FROM favorites WHERE id = ?', [event.id]);
      add(GetFromFavoriteDatabaseEvent());
      print('deleted1: $id1');
    });
  }

  FutureOr<void> _isInFavoriteDatabase(
      IsInFavoriteDatabaseEvent event, Emitter<MokaState> emit) async {
    bool isContain = false;
    int elementId = 0;
    if (state.favoritesItems!.isNotEmpty) {
      for (var element in state.favoritesItems as List<Map>) {
        if (element['name'] == event.itemDetails.title) {
          isContain = true;
          elementId = element['id'];
          break;
        }
      }
      if (isContain) {
        add(DeleteFromFavoriteDatabaseEvent(elementId));
      } else {
        add(InsertToFavoritesDatabaseEvent(event.itemDetails));
      }
    } else {
      add(InsertToFavoritesDatabaseEvent(event.itemDetails));
    }
  }

  FutureOr<void> _getFirstToken(
      getFirstTokenEvent event, Emitter<MokaState> emit) async {
    print('object : 1');
    emit(state.copyWith(
      cartState: RequestState.loading,
    ));
    final result = await getFirstTokenUseCase(event.price);
    ApiConstance.PAYMENT_FIRST_TOKEN = result.data['token'];
    add(getOrderIdEvent(event.price));
  }

  FutureOr<void> _getOrderId(
      getOrderIdEvent event, Emitter<MokaState> emit) async {
    print('object : 2');

    final result = await getOrderIdUseCase(event.price);
    ApiConstance.PAYMENT_ORDER_ID = result.data['id'].toString();
    add(getFinalTokenCardVisaEvent(event.price));
    add(getFinalTokenKioskEvent(event.price));
  }

  FutureOr<void> _getFinalTokenCardVisa(
      getFinalTokenCardVisaEvent event, Emitter<MokaState> emit) async {
    print('object : 3');

    final result = await getFinalTokenCardVisaUseCase(event.price);
    ApiConstance.PAYMENT_FINAL_TOKEN_VISA = result.data['token'];
  }

  FutureOr<void> _getFinalTokenKiosk(
      getFinalTokenKioskEvent event, Emitter<MokaState> emit) async {
    print('object : 4');
    final result = await getFinalTokenKioskUseCase(event.price);
    ApiConstance.PAYMENT_FINAL_TOKEN_KIOSK = result.data['token'];
    add(getReferenceCodeEvent());
  }

  FutureOr<void> _getReferenceCode(
      getReferenceCodeEvent event, Emitter<MokaState> emit) async {
    final result = await getReferenceCodeUseCase();
    ApiConstance.REFCODE = result.data['id'].toString();
    emit(state.copyWith(
      cartState: RequestState.loaded,
    ));
    emit(state.copyWith(
      cartState: RequestState.error,
    ));
  }

  FutureOr<void> _changeMode(
      changeModeEvent event, Emitter<MokaState> emit) async {
    if (event.isDark == true && state.isDark == false) {
      await CacheHelper.saveData(key: AppConstants.isDark, value: true)
          .then((value) {
        emit(state.copyWith(
          isDark: true,
        ));
      });
    }

    if (event.isDark == false && state.isDark == true) {
      await CacheHelper.saveData(key: AppConstants.isDark, value: false)
          .then((value) {
        emit(state.copyWith(
          isDark: false,
        ));
      });
    }
  }

  FutureOr<void> _changeLang(
      changeLangEvent event, Emitter<MokaState> emit) async {
    await changeLangUseCase.call(event.langCode);
    emit(state.copyWith(
      locale: Locale(event.langCode),
    ));
  }

  FutureOr<void> _getSavedLang(
      getSavedLangEvent event, Emitter<MokaState> emit) async {
    final response = await getSavedLangUseCase.call();
    emit(state.copyWith(
      locale: Locale(response),
    ));
  }

  FutureOr<void> _setFilterProduct(
      setFilterProductEvent event, Emitter<MokaState> emit) {
    emit(state.copyWith(
      filterProduct: event.filterProduct,
    ));
  }

  FutureOr<void> _openFilter(openFilterEvent event, Emitter<MokaState> emit) {
    print(state.isOpenFilter);
    emit(state.copyWith(
      isOpenFilter: state.isOpenFilter == false ? true : false,
    ));
    print(state.isOpenFilter);
  }

  FutureOr<void> _closeFilter(closeFilterEvent event, Emitter<MokaState> emit) {
    emit(state.copyWith(
      isOpenFilter: false,
    ));
  }
}
