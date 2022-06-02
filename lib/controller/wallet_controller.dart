import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/challenges_binding.dart';
import 'package:satorio/binding/wallet_in_app_purchase_binding.dart';
import 'package:satorio/binding/wallet_receive_binding.dart';
import 'package:satorio/binding/wallet_send_binding.dart';
import 'package:satorio/binding/wallet_stake_binding.dart';
import 'package:satorio/controller/wallet_receive_controller.dart';
import 'package:satorio/controller/wallet_send_controller.dart';
import 'package:satorio/controller/wallet_stake_controller.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/challenges_page.dart';
import 'package:satorio/ui/page_widget/wallet_in_app_purchase_page.dart';
import 'package:satorio/ui/page_widget/wallet_receive_page.dart';
import 'package:satorio/ui/page_widget/wallet_send_page.dart';
import 'package:satorio/ui/page_widget/wallet_stake_page.dart';

class WalletController extends GetxController {
  static const _initPage = 0;
  final SatorioRepository _satorioRepository = Get.find();

  late PageController pageController;
  final RxInt pageRx = _initPage.obs;

  Map<String, Wallet> wallets = {};
  Rx<List<WalletDetail>> walletDetailsRx = Rx([]);
  Rx<Map<String, List<Transaction>>> walletTransactionsRx = Rx({});

  late ValueListenable<Box<Wallet>> _walletsListenable;
  ValueListenable<Box<WalletDetail>>? _walletDetailsListenable;
  late ValueListenable<Box<Transaction>> _transactionListenable;

  RxBool _isMoreLoading = false.obs;

  Rx<bool> isClaimLoadRx = Rx(false);

  WalletController() {
    _walletsListenable =
        _satorioRepository.walletsListenable() as ValueListenable<Box<Wallet>>;

    _transactionListenable = _satorioRepository.transactionsListenable()
        as ValueListenable<Box<Transaction>>;
  }

  @override
  void onInit() {
    super.onInit();
    refreshAllWallets();

    _walletsListenable.addListener(_walletsListener);
    _transactionListenable.addListener(_transactionsListener);
  }

  @override
  void onClose() {
    pageController.removeListener(_pageListener);
    _walletsListenable.removeListener(_walletsListener);
    _transactionListenable.removeListener(_transactionsListener);
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    super.onClose();
  }

  void setupPageController(double viewportFraction) {
    pageController = PageController(
      initialPage: _initPage,
      keepPage: true,
      viewportFraction: viewportFraction,
    );
    pageController.addListener(_pageListener);
    resetPageToInitValue();
  }

  void resetPageToInitValue() {
    pageRx.value = _initPage;
  }

  void _pageListener() {
    final int page = pageController.page?.round() ?? 0;

    if (page != pageRx.value) {
      if (page < walletDetailsRx.value.length) {
        String walletId = walletDetailsRx.value[page].id;
        Wallet? wallet = wallets[walletId];
        _updateWalletDetail(wallet);
        _updateTransaction(wallet);
      }

      pageRx.value = page;
    }
  }

  void _walletsListener() {
    // Update wallets map
    Map<String, Wallet> walletsNew = {};
    _walletsListenable.value.values.forEach((wallet) {
      walletsNew[wallet.id] = wallet;
    });
    wallets = walletsNew;

    // Ids of wallets
    List<String> ids = wallets.values.map((wallet) => wallet.id).toList();

    // Re-subscribe to new actual ids
    _walletDetailsListenable?.removeListener(_walletDetailsListener);
    _walletDetailsListenable = _satorioRepository.walletDetailsListenable(ids)
        as ValueListenable<Box<WalletDetail>>;
    _walletDetailsListenable?.addListener(_walletDetailsListener);

    // Reset all transaction & load for first wallet
    Map<String, List<Transaction>> walletTransactionsNew = {};
    wallets.values.forEach((wallet) {
      walletTransactionsNew[wallet.id] = [];
    });
    walletTransactionsRx.value = walletTransactionsNew;
    _transactionsListener();
  }

  void _walletDetailsListener() {
    List<WalletDetail> walletDetails =
        _walletDetailsListenable!.value.values.toList();
    walletDetails.sort((a, b) => a.order.compareTo(b.order));
    walletDetailsRx.value = walletDetails;
  }

  void _transactionsListener() {
    Iterable<Transaction> allTransactions = _transactionListenable.value.values;
    walletTransactionsRx.update((value) {
      for (String walletId in value!.keys) {
        List<Transaction> transactions = allTransactions
            .where((transaction) => transaction.walletId == walletId)
            .toList();
        transactions.sort((a, b) => a.createdAt != null && b.createdAt != null
            ? b.createdAt!.compareTo(a.createdAt!)
            : 0);
        value[walletId] = transactions;
      }
    });
  }

  void _updateWalletDetail(Wallet? wallet) {
    if (wallet != null) {
      _satorioRepository.updateWalletDetail(wallet.detailsUrl);
    }
  }

  void _updateTransaction(Wallet? wallet) {
    if (wallet != null && wallet.transactionsUrl.isNotEmpty) {
      // TODO
      final WalletDetail? walletDetail = walletDetailsRx.value
          .firstWhereOrNull((element) => element.id == wallet.id);
      print(
          '_updateTransaction ${wallet.transactionsUrl} ${walletDetail?.id} ${walletDetail?.solanaAccountAddress}');

      List<DateTime> trxDateTimes = _transactionListenable.value.values
          .where((element) =>
              element.walletId == wallet.id && element.createdAt != null)
          .map((element) => element.createdAt!)
          .toList();

      DateTime? fromDateTime = trxDateTimes.isEmpty
          ? null
          : trxDateTimes.reduce((a, b) => a.isAfter(b) ? a : b);

      _satorioRepository.updateWalletTransactions(wallet.transactionsUrl,
          from: fromDateTime);
    }
  }

  void toTopUp() {
    Get.to(
      () => WalletInAppPurchasePage(),
      binding: WalletInAppPurchaseBinding(),
    );
  }

  void toReceive(WalletDetail walletDetail) {
    Get.to(
      () => WalletReceivePage(),
      binding: WalletReceiveBinding(),
      arguments: WalletReceiveArgument(walletDetail),
    );
  }

  void toSend(WalletDetail walletDetail) {
    Get.to(
      () => WalletSendPage(),
      binding: WalletSendBinding(),
      arguments: WalletSendArgument(walletDetail, null),
    );
  }

  void toChallenges() {
    Get.to(
      () => ChallengesPage(),
      binding: ChallengesBinding(),
    );
  }

  void toStake(WalletDetail walletDetail) {
    Get.to(
      () => WalletStakePage(),
      binding: WalletStakeBinding(),
      arguments: WalletStakeArgument(walletDetail),
    );
  }

  void toClaimRewards(String claimRewardsPath) {
    Future.value(true)
        .then(
          (value) {
            isClaimLoadRx.value = true;
            return value;
          },
        )
        .then(
          (value) => _satorioRepository.claimReward(claimRewardsPath),
        )
        .then(
          (ClaimReward claimReward) {
            Get.bottomSheet(
              ClaimRewardsBottomSheet(
                claimReward,
                () {
                  refreshAllWallets();
                },
              ),
            );
            isClaimLoadRx.value = false;
          },
        )
        .catchError((error) {
          isClaimLoadRx.value = false;
        });
  }

  void refreshAllWallets() {
    _satorioRepository.updateWallets().then((List<Wallet> wallets) {
      wallets.forEach((wallet) {
        _updateWalletDetail(wallet);
      });
      if (wallets.isNotEmpty) _updateTransaction(wallets[pageRx.value]);
    });
  }

  void loadMoreTransactions() {
    if (_isMoreLoading.value) return;

    _isMoreLoading.value = true;

    String walletId = walletDetailsRx.value[pageRx.value].id;
    Wallet? wallet = wallets[walletId];
    if (wallet != null && wallet.transactionsUrl.isNotEmpty) {
      List<DateTime> trxDateTimes = _transactionListenable.value.values
          .where((element) =>
              element.walletId == wallet.id && element.createdAt != null)
          .map((element) => element.createdAt!)
          .toList();

      DateTime? toDateTime = trxDateTimes.isEmpty
          ? null
          : trxDateTimes.reduce((a, b) => a.isBefore(b) ? a : b);

      _satorioRepository
          .updateWalletTransactions(wallet.transactionsUrl, to: toDateTime)
          .then((value) => _isMoreLoading.value = false)
          .catchError((value) {
        _isMoreLoading.value = false;
      });
    }
  }
}
