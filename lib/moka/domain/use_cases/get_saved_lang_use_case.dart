import '../repositories/base_moka_respositry.dart';

class GetSavedLangUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetSavedLangUseCase(this.baseMokaRepository);

  Future<String> call() async {
    return await baseMokaRepository.getSavedLang();
  }
}
