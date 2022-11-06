import 'package:dio/dio.dart';

import '../repositories/base_moka_respositry.dart';

class GetOrderIdUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetOrderIdUseCase(this.baseMokaRepository);

  Future<Response<dynamic>> call(String price) async {
    return await baseMokaRepository.getOrderId(price);
  }
}
