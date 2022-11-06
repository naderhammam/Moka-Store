import 'package:dio/dio.dart';

import '../repositories/base_moka_respositry.dart';

class GetFinalTokenCardVisaUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetFinalTokenCardVisaUseCase(this.baseMokaRepository);

  Future<Response<dynamic>> call(String price) async {
    return await baseMokaRepository.getFinalTokenCardVisa(price);
  }
}
