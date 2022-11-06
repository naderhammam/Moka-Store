import 'package:dio/src/response.dart';
import 'package:moka_store/moka/data/data_sources/moka_remote_data_source.dart';
import 'package:moka_store/moka/domain/entities/item_details.dart';
import 'package:moka_store/moka/domain/repositories/base_moka_respositry.dart';

class MokaRepository extends BaseMokaRepository {
  final BaseMokaRemoteDataSource baseMokaRemoteDataSource;

  MokaRepository(this.baseMokaRemoteDataSource);

  @override
  Future<List<ItemDetails>> getElectronicsProduct() async {
    return await baseMokaRemoteDataSource.getElectronicsProduct();
  }

  @override
  Future<List<ItemDetails>> getSupermarketProduct() async {
    return await baseMokaRemoteDataSource.getSupermarketProduct();
  }

  @override
  Future<List<ItemDetails>> getMenProduct() {
    return baseMokaRemoteDataSource.getMenProduct();
  }

  @override
  Future<List<ItemDetails>> getWatchesProduct() {
    return baseMokaRemoteDataSource.getWatchesProduct();
  }

  @override
  Future<List<ItemDetails>> getWomenProduct() {
    return baseMokaRemoteDataSource.getWomenProduct();
  }

  @override
  Future<List<ItemDetails>> getAllProduct() {
    return baseMokaRemoteDataSource.getAllProduct();
  }

  @override
  Future<Response> getFinalTokenCardVisa(String price) {
    return baseMokaRemoteDataSource.getFinalTokenCardVisa(price);
  }

  @override
  Future<Response> getFinalTokenKiosk(String price) {
    return baseMokaRemoteDataSource.getFinalTokenKiosk(price);
  }

  @override
  Future<Response> getFirstToken(String price) {
    return baseMokaRemoteDataSource.getFirstToken(price);
  }

  @override
  Future<Response> getOrderId(String price) {
    return baseMokaRemoteDataSource.getOrderId(price);
  }

  @override
  Future<Response> getReferenceCode() {
    return baseMokaRemoteDataSource.getReferenceCode();
  }

  @override
  Future<bool> changeLang(String langCode) {
    return baseMokaRemoteDataSource.changeLang(langCode);
  }

  @override
  Future<String> getSavedLang() {
    return baseMokaRemoteDataSource.getSavedLang();
  }
}
