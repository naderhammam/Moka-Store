import 'package:get_it/get_it.dart';
import 'package:moka_store/moka/domain/use_cases/get_all_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_electronics_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_final_token_card_visa_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_final_token_kiosk_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_first_token_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_men_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_order_id_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_reference_code_use_case.dart';
import 'package:moka_store/moka/domain/use_cases/get_saved_lang_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../moka/data/data_sources/moka_remote_data_source.dart';
import '../../moka/data/repositories/moka_repository.dart';
import '../../moka/domain/repositories/base_moka_respositry.dart';
import '../../moka/domain/use_cases/change_lang_use_case.dart';
import '../../moka/domain/use_cases/get_supermarket_use_case.dart';
import '../../moka/domain/use_cases/get_watches_use_case.dart';
import '../../moka/domain/use_cases/get_women_use_case.dart';
import '../../moka/presentation/controller/moka_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// BLOC
    sl.registerFactory(() => MokaBloc(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));

    /// USE CASES
    sl.registerLazySingleton(() => GetElectronicsProductUseCase(sl()));
    sl.registerLazySingleton(() => GetSupermarketProductUseCase(sl()));
    sl.registerLazySingleton(() => GetMenProductUseCase(sl()));
    sl.registerLazySingleton(() => GetWomenProductUseCase(sl()));
    sl.registerLazySingleton(() => GetWatchesProductUseCase(sl()));
    sl.registerLazySingleton(() => GetFirstTokenUseCase(sl()));
    sl.registerLazySingleton(() => GetOrderIdUseCase(sl()));
    sl.registerLazySingleton(() => GetFinalTokenCardVisaUseCase(sl()));
    sl.registerLazySingleton(() => GetFinalTokenKioskUseCase(sl()));
    sl.registerLazySingleton(() => GetReferenceCodeUseCase(sl()));
    sl.registerLazySingleton(() => GetAllProductUseCase(sl()));
    sl.registerLazySingleton(() => GetSavedLangUseCase(sl()));
    sl.registerLazySingleton(() => ChangeLangUseCase(sl()));

    /// REPOSITORY
    sl.registerLazySingleton<BaseMokaRepository>(() => MokaRepository(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMokaRemoteDataSource>(
        () => MokaRemoteDataSource(sl()));

    /// External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
  }
}
