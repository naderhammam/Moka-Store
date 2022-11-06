import 'package:dio/dio.dart';

import '../repositories/base_moka_respositry.dart';

class GetFirstTokenUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetFirstTokenUseCase(this.baseMokaRepository);

  Future<Response<dynamic>> call(String price) async {
    return await baseMokaRepository.getFirstToken(price);
  }
}
