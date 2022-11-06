import 'package:dio/dio.dart';

import '../repositories/base_moka_respositry.dart';

class GetReferenceCodeUseCase {
  final BaseMokaRepository repository;

  GetReferenceCodeUseCase(this.repository);

  Future<Response<dynamic>> call() async {
    return await repository.getReferenceCode();
  }
}
