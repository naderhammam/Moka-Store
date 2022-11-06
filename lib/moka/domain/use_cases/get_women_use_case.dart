import 'package:moka_store/moka/domain/entities/item_details.dart';

import '../repositories/base_moka_respositry.dart';

class GetWomenProductUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetWomenProductUseCase(this.baseMokaRepository);

  Future<List<ItemDetails>> call() async {
    return await baseMokaRepository.getWomenProduct();
  }
}
