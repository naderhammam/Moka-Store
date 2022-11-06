import 'package:dio/dio.dart';

import '../repositories/base_moka_respositry.dart';

class GetFinalTokenKioskUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetFinalTokenKioskUseCase(this.baseMokaRepository);

  Future<Response<dynamic>> call(String price) async {
    return await baseMokaRepository.getFinalTokenKiosk(price);
  }
}
