import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/wallet_receive_binding.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/wallet_receive_page.dart';

class WalletController extends GetxController {
  static const _initPage = 0;
  final SatorioRepository _satorioRepository = Get.find();

  late PageController pageController;

  Map<String, Wallet> wallets = {};
  Rx<List<WalletDetail>> walletDetailsRx = Rx([]);
  RxInt pageRx = RxInt(_initPage);

  Rx<Map<String, List<Transaction>>> walletTransactionsRx = Rx({});

  late ValueListenable<Box<Wallet>> _walletsListenable;
  ValueListenable<Box<WalletDetail>>? _walletDetailsListenable;

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
    pageController.removeListener(_changePage);
    _walletsListenable.removeListener(_walletsListener);
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    super.onClose();
  }

  void setupPageController(double viewportFraction) {
    pageController = PageController(viewportFraction: viewportFraction);
    pageController.addListener(_changePage);
  }

  void _changePage() {
    int page = pageController.page?.round() ?? 0;
    if (page < walletDetailsRx.value.length) {
      String id = walletDetailsRx.value[page].id;

      if (walletTransactionsRx.value[id]?.isEmpty ?? false) {
        Wallet? wallet = wallets[id];
        _updateTransaction(wallet);
      }
    }

    pageRx.value = page;
  }

  void _walletsListener() {
    List<Wallet> walletsNew = _walletsListenable.value.values.toList();

    // Update wallets map
    Map<String, Wallet> walletsTmp = {};
    _walletsListenable.value.values.forEach((wallet) {
      walletsTmp[wallet.id] = wallet;
    });
    wallets = walletsTmp;

    // Ids of wallets
    List<String> ids = wallets.values.map((wallet) => wallet.id).toList();

    // Re-subscribe to new actual ids
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    _walletDetailsListenable = _satorioRepository.walletDetailsListenable(ids)
        as ValueListenable<Box<WalletDetail>>;
    _walletDetailsListenable?.addListener(_walletDetailsListener);

    // Update wallet detail for each wallet
    wallets.values.forEach((wallet) {
      _updateWalletDetail(wallet);
    });

    // Reset all transaction & load for first wallet
    Map<String, List<Transaction>> walletTransactionsNew = {};
    wallets.values.forEach((wallet) {
      walletTransactionsNew[wallet.id] = [];
    });
    walletTransactionsRx.value = walletTransactionsNew;
    _updateTransaction(walletsNew[pageRx.value]);
  }

  void _walletDetailsListener() {
    walletDetailsRx.value = _walletDetailsListenable!.value.values.toList();
  }

  void _updateWalletDetail(Wallet wallet) {
    _satorioRepository.updateWalletDetail(wallet.detailsUrl);
  }

  void _updateTransaction(Wallet? wallet) {
    if (wallet != null && (wallet.transactionsUrl.isNotEmpty)) {
      _satorioRepository
          .walletTransactions(wallet.transactionsUrl)
          .then((List<Transaction> transactions) {
        walletTransactionsRx.update((value) {
          value?[wallet.id] = transactions;
        });
      });
    }
  }

  void toReceive(WalletDetail walletDetail) {
    Get.to(
      () => WalletReceivePage(walletDetail),
      binding: WalletReceiveBinding(),
    );
  }

  void toSend(WalletDetail walletDetail) {}

  void claimRewards(String claimRewardsPath) {
    _satorioRepository.claimReward(claimRewardsPath).then(
      (ClaimReward claimReward) {
        Get.bottomSheet(
          ClaimRewardsBottomSheet(claimReward),
        );
      },
    );
  }

  void refreshWallet() {
    _satorioRepository.updateWallets();
  }
}
