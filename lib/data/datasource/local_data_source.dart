import 'package:flutter/foundation.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:webfeed/webfeed.dart';

abstract class LocalDataSource {
  Future<void> init();

  Future<void> clear();

  Future<void> markOnBoarded();

  Future<void> markIsBiometricEnabled(bool isBiometricEnabled);

  Future<void> markIsBiometricUserDisabled();

  Future<bool> isOnBoarded();

  Future<bool> isBiometricEnabled();

  Future<bool?> isBiometricUserDisabled();

  Future<void> saveProfile(Profile profile);

  ValueListenable profileListenable();

  Future<void> saveWalletBalance(List<AmountCurrency> walletBalance);

  ValueListenable walletBalanceListenable();

  Future<void> saveWallets(List<Wallet> wallets);

  ValueListenable walletsListenable();

  Future<void> saveWalletDetail(WalletDetail walletDetail);

  ValueListenable walletDetailsListenable(List<String>? ids);

  Future<void> saveTransactions(List<Transaction> transactions);

  ValueListenable transactionsListenable();

  Future<void> saveRssItems(List<RssItem> feedItems);

  ValueListenable rssItemsListenable();
}
