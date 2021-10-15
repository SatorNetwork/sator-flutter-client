import 'package:get/get.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class NftItemController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<NftItem> nftItemRx;

  NftItemController() {
    NftItemArgument argument = Get.arguments as NftItemArgument;

    nftItemRx = Rx(argument.nftItem);
    _refreshNftItem(argument.nftItem.id);
  }

  void back() {
    Get.back();
  }

  void buy() {}

  void addToFavourite() {}

  void _refreshNftItem(String nftItemId) {
    _satorioRepository.nftItem(nftItemId).then((NftItem nftItem) {
      nftItemRx.value = nftItem;
    });
  }
}

class NftItemArgument {
  final NftItem nftItem;

  const NftItemArgument(this.nftItem);
}
