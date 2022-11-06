import '../repositories/base_moka_respositry.dart';

class ChangeLangUseCase {
  final BaseMokaRepository baseMokaRepository;

  ChangeLangUseCase(this.baseMokaRepository);

  Future<bool> call(String langCode) async {
    return await baseMokaRepository.changeLang(langCode);
  }
}
