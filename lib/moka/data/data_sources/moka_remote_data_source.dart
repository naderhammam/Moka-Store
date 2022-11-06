import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:moka_store/core/utils/constants_manager.dart';
import 'package:moka_store/moka/data/models/item_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/helper/dio_helper.dart';
import '../../../core/network/api_constance.dart';

abstract class BaseMokaRemoteDataSource {
  Future<List<ItemDetailsModel>> getElectronicsProduct();

  Future<List<ItemDetailsModel>> getSupermarketProduct();

  Future<List<ItemDetailsModel>> getWatchesProduct();

  Future<List<ItemDetailsModel>> getMenProduct();

  Future<List<ItemDetailsModel>> getWomenProduct();

  Future<List<ItemDetailsModel>> getAllProduct();

  Future<Response<dynamic>> getFirstToken(String price);

  Future<Response<dynamic>> getOrderId(String price);

  Future<Response<dynamic>> getFinalTokenCardVisa(String price);

  Future<Response<dynamic>> getFinalTokenKiosk(String price);

  Future<Response<dynamic>> getReferenceCode();

  Future<bool> changeLang(String langCode);

  Future<String> getSavedLang();
}

/// no handle error because it's handled in the repository
/// im backend i sure that the data is correct
/// the data is correct because i'm the one who created it
/// i know it's wrong but it's just a test

class MokaRemoteDataSource extends BaseMokaRemoteDataSource {
  final SharedPreferences sharedPreferences;

  MokaRemoteDataSource(this.sharedPreferences);

  @override
  Future<List<ItemDetailsModel>> getElectronicsProduct() async {
    List<ItemDetailsModel> result = [];
    final response =
        await FirebaseFirestore.instance.collection('electronics').get();

    for (var element in response.docs) {
      result.add(ItemDetailsModel.fromJson(element.data()));
    }
    return result;
  }

  @override
  Future<List<ItemDetailsModel>> getSupermarketProduct() async {
    List<ItemDetailsModel> result = [];
    final response =
        await FirebaseFirestore.instance.collection('supermarket').get();

    for (var element in response.docs) {
      result.add(ItemDetailsModel.fromJson(element.data()));
    }
    return result;
  }

  @override
  Future<List<ItemDetailsModel>> getMenProduct() async {
    List<ItemDetailsModel> result = [];
    final response = await FirebaseFirestore.instance.collection('men').get();

    for (var element in response.docs) {
      result.add(ItemDetailsModel.fromJson(element.data()));
    }
    return result;
  }

  @override
  Future<List<ItemDetailsModel>> getWatchesProduct() async {
    List<ItemDetailsModel> result = [];
    final response =
        await FirebaseFirestore.instance.collection('watches').get();

    for (var element in response.docs) {
      result.add(ItemDetailsModel.fromJson(element.data()));
    }
    return result;
  }

  @override
  Future<List<ItemDetailsModel>> getWomenProduct() async {
    List<ItemDetailsModel> result = [];
    final response = await FirebaseFirestore.instance.collection('women').get();

    for (var element in response.docs) {
      result.add(ItemDetailsModel.fromJson(element.data()));
    }
    return result;
  }

  @override
  Future<List<ItemDetailsModel>> getAllProduct() async {
    List<ItemDetailsModel> result = [];
    final response = await FirebaseFirestore.instance.collection('all').get();

    for (var element in response.docs) {
      result.add(ItemDetailsModel.fromJson(element.data()));
    }
    return result;
  }

  @override
  Future<Response> getFinalTokenCardVisa(String price) async {
    final response = await DioHelper.postData(
        endPoint: ApiConstance.FINAL_TOKEN_ENDPOINT,
        data: {
          "auth_token": ApiConstance.PAYMENT_FIRST_TOKEN,
          "amount_cents": price,
          "expiration": 3600,
          "order_id": ApiConstance.PAYMENT_ORDER_ID,
          "billing_data": {
            "apartment": "NA",
            "email": "admin@gmail.com",
            "floor": "NA",
            "first_name": "admin",
            "street": "NA",
            "building": "NA",
            "phone_number": "0123456789",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": "admin",
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": ApiConstance.INTEGRATION_ID_VISACARD
        });
    return response;
  }

  @override
  Future<Response> getFinalTokenKiosk(String price) async {
    final response = await DioHelper.postData(
        endPoint: ApiConstance.FINAL_TOKEN_ENDPOINT,
        data: {
          "auth_token": ApiConstance.PAYMENT_FIRST_TOKEN,
          "amount_cents": price,
          "expiration": 3600,
          "order_id": ApiConstance.PAYMENT_ORDER_ID,
          "billing_data": {
            "apartment": "NA",
            "email": "admin@gmail.com",
            "floor": "NA",
            "first_name": "admin",
            "street": "NA",
            "building": "NA",
            "phone_number": "0123456789",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": "admin",
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": ApiConstance.INTEGRATION_ID_KIOSK
        });
    return response;
  }

  @override
  Future<Response> getFirstToken(String price) async {
    final response = await DioHelper.postData(
        endPoint: ApiConstance.FIRST_TOKEN_ENDPOINT,
        data: {"api_key": ApiConstance.APIKEY});
    return response;
  }

  @override
  Future<Response> getOrderId(String price) async {
    final response = await DioHelper.postData(
      endPoint: ApiConstance.ORDER_ID_ENDPOINT,
      data: {
        "auth_token": ApiConstance.PAYMENT_FIRST_TOKEN,
        "delivery_needed": "false",
        "amount_cents": price,
        "currency": "EGP",
        "items": [],
      },
    );
    return response;
  }

  @override
  Future<Response> getReferenceCode() async {
    final response = await DioHelper.postData(
        endPoint: ApiConstance.REFCODE_ENDPOINT,
        data: {
          "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
          "payment_token": ApiConstance.PAYMENT_FINAL_TOKEN_KIOSK
        });
    return response;
  }

  @override
  Future<bool> changeLang(String langCode) async {
    return await sharedPreferences.setString(AppConstants.locale, langCode);
  }

  @override
  Future<String> getSavedLang() async {
    return sharedPreferences.containsKey(AppConstants.locale)
        ? sharedPreferences.getString(AppConstants.locale)!
        : AppConstants.englishCode;
  }
}
