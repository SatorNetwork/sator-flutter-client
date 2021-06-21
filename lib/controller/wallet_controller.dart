import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class WalletController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final PageController pageController;

  Rx<List<Wallet>> walletsRx = Rx([]);
  Rx<Map<String, WalletDetail>> walletDetailsRx = Rx({});

  late ValueListenable<Box<Wallet>> _walletsListenable;
  ValueListenable<Box<WalletDetail>>? _walletDetailsListenable;

  Rx<List<double>> transactionsRx = Rx([
    124.0,
    -24.0,
    -35.0,
    249.52,
    1998254.39,
    1198254.39,
    -19254.39,
    19655.39,
    1189.39,
    24.0,
    -24.0,
    -12.12
  ]);

  WalletController() {
    _walletsListenable =
        _satorioRepository.walletsListenable() as ValueListenable<Box<Wallet>>;
  }

  @override
  void onInit() {
    super.onInit();

    _walletsListenable.addListener(_walletsListener);
  }

  @override
  void onClose() {
    _walletsListenable.removeListener(_walletsListener);
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    super.onClose();
  }

  void send() {}

  void receive() {}

  void _walletsListener() {
    List<Wallet> wallets = _walletsListenable.value.values.toList();
    walletsRx.value = wallets;

    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    _walletDetailsListenable = _satorioRepository.walletDetailsListenable(
      wallets.map((wallet) => wallet.id).toList(),
    ) as ValueListenable<Box<WalletDetail>>;
    _walletDetailsListenable?.addListener(_walletDetailsListener);
  }

  void _walletDetailsListener() {
    List<WalletDetail> walletDetails =
        _walletDetailsListenable!.value.values.toList();

    if (walletDetails.isNotEmpty) {
      walletDetailsRx.update((value) {
        walletDetails.forEach((walletDetail) {
          value?[walletDetail.id] = walletDetail;
        });
      });
    }
  }
}
