import 'package:dio/dio.dart';
import 'package:moka_store/core/network/api_constance.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.BASEURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData(
      {required String endPoint, required Map<String, dynamic> data}) async {
    dio.options.headers = {"Content-Type": "application/json"};
    return dio.post(endPoint, data: data);
  }
}
