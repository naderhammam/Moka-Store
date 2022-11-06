import 'package:moka_store/moka/domain/entities/item_details.dart';

import '../repositories/base_moka_respositry.dart';

class GetWatchesProductUseCase {
  final BaseMokaRepository baseMokaRepository;

  GetWatchesProductUseCase(this.baseMokaRepository);

  Future<List<ItemDetails>> call() async {
    return await baseMokaRepository.getWatchesProduct();
  }
}
