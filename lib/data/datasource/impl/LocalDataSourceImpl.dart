import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/db_adapter/amount_currency_adapter.dart';
import 'package:satorio/data/db_adapter/profile_adapter.dart';
import 'package:satorio/data/db_adapter/rss_item_adapter.dart';
import 'package:satorio/data/db_adapter/transaction_adapter.dart';
import 'package:satorio/data/db_adapter/wallet_action_adapter.dart';
import 'package:satorio/data/db_adapter/wallet_adapter.dart';
import 'package:satorio/data/db_adapter/wallet_detail_adapter.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:webfeed/domain/rss_item.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const _profileBox = 'profile';
  static const _walletBalanceBox = 'walletBalance';
  static const _walletBox = 'wallet';
  static const _walletDetailBox = 'walletDetail';
  static const _transactionBox = 'transaction';
  static const _rssItemBox = 'rssItem';

  static const _isBiometricEnabled = 'isBiometricEnabled';
  static const _isBiometricUserDisabled = 'isBiometricUserDisabled';
  static const _onBoarded = 'onBoarded';
  static const _lastRssUpdate = 'lastRssUpdate';

  GetStorage _storage = GetStorage('LocalDataSource');

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(AmountCurrencyAdapter());
    Hive.registerAdapter(WalletAdapter());
    Hive.registerAdapter(WalletActionAdapter());
    Hive.registerAdapter(WalletDetailAdapter());
    Hive.registerAdapter(TransactionAdapter());
    Hive.registerAdapter(RssItemAdapter());

    try {
      await _open();
    } catch (HiveError) {
      await _delete();
      await _open();
    }
  }

  Future<void> _open() async {
    await Hive.openBox<Profile>(_profileBox);
    await Hive.openBox<AmountCurrency>(_walletBalanceBox);
    await Hive.openBox<Wallet>(_walletBox);
    await Hive.openBox<WalletDetail>(_walletDetailBox);
    await Hive.openBox<Transaction>(_transactionBox);
    await Hive.openBox<RssItem>(_rssItemBox);
  }

  Future<void> _delete() async {
    await Hive.deleteBoxFromDisk(_profileBox);
    await Hive.deleteBoxFromDisk(_walletBalanceBox);
    await Hive.deleteBoxFromDisk(_walletBox);
    await Hive.deleteBoxFromDisk(_walletDetailBox);
    await Hive.deleteBoxFromDisk(_transactionBox);
    await Hive.deleteBoxFromDisk(_rssItemBox);
  }

  @override
  Future<void> clear() async {
    await Hive.box<Profile>(_profileBox).clear();
    await Hive.box<AmountCurrency>(_walletBalanceBox).clear();
    await Hive.box<Wallet>(_walletBox).clear();
    await Hive.box<WalletDetail>(_walletDetailBox).clear();
    await Hive.box<Transaction>(_transactionBox).clear();
  }

  @override
  Future<void> markOnBoarded() async {
    return _storage.write(_onBoarded, true);
  }

  @override
  Future<void> markIsBiometricEnabled(bool isBiometricEnabled) async {
    return _storage.write(_isBiometricEnabled, isBiometricEnabled);
  }

  @override
  Future<void> markIsBiometricUserDisabled() async {
    return _storage.write(_isBiometricUserDisabled, false);
  }

  @override
  Future<bool> isOnBoarded() async {
    // dynamic tmp = _storage.read(_onBoarded);
    // final bool result = tmp != null && tmp is bool ? tmp : false;
    // return result;
    return true;
  }

  @override
  Future<bool> isBiometricEnabled() async {
    dynamic isBiometricEnabled = _storage.read(_isBiometricEnabled);
    if (isBiometricEnabled != null)
      return isBiometricEnabled;
    else
      return false;
  }

  @override
  Future<bool?> isBiometricUserDisabled() async {
    dynamic isBiometricUserDisabled = _storage.read(_isBiometricUserDisabled);
    if (isBiometricUserDisabled != null)
      return isBiometricUserDisabled;
    else
      return null;
  }

  @override
  Future<void> saveProfile(Profile profile) {
    return Hive.box<Profile>(_profileBox).put(0, profile);
  }

  @override
  ValueListenable profileListenable() {
    return Hive.box<Profile>(_profileBox).listenable();
  }

  @override
  Future<void> saveWalletBalance(List<AmountCurrency> wallet) {
    Box<AmountCurrency> walletBalanceBox =
        Hive.box<AmountCurrency>(_walletBalanceBox);
    return walletBalanceBox
        .clear()
        .then((value) => walletBalanceBox.addAll(wallet))
        .then((value) {
      return;
    });
  }

  @override
  ValueListenable walletBalanceListenable() {
    return Hive.box<AmountCurrency>(_walletBalanceBox).listenable();
  }

  @override
  Future<void> saveWallets(List<Wallet> wallets) async {
    Map<String, Wallet> walletMap = {};
    wallets.forEach((wallet) {
      walletMap[wallet.id] = wallet;
    });

    Box<Wallet> walletsBox = Hive.box<Wallet>(_walletBox);
    walletsBox.putAll(walletMap);
  }

  @override
  ValueListenable walletsListenable() {
    return Hive.box<Wallet>(_walletBox).listenable();
  }

  @override
  Future<void> saveWalletDetail(WalletDetail walletDetail) async {
    Hive.box<WalletDetail>(_walletDetailBox).put(
      walletDetail.id,
      walletDetail,
    );
  }

  @override
  ValueListenable walletDetailsListenable(List<String>? ids) {
    return Hive.box<WalletDetail>(_walletDetailBox).listenable(keys: ids);
  }

  @override
  Future<void> saveTransactions(List<Transaction> transactions) async {
    final Map<String, Transaction> transactionMap = {};
    transactions.forEach((transaction) {
      transactionMap[transaction.id] = transaction;
    });

    Box<Transaction> transactionBox = Hive.box<Transaction>(_transactionBox);
    transactionBox.putAll(transactionMap);
  }

  @override
  ValueListenable transactionsListenable() {
    return Hive.box<Transaction>(_transactionBox).listenable();
  }

  @override
  Future<DateTime?> lastRssUpdateTime() async {
    final String lastRssUpdate = _storage.read(_lastRssUpdate) ?? '';
    return DateTime.tryParse(lastRssUpdate);
  }

  @override
  Future<void> saveRssItems(List<RssItem> feedItems) async {
    final DateTime now = DateTime.now();

    final Map<String, RssItem> rssItemsMap = {};
    feedItems
        .where((element) => element.guid != null && element.guid!.isNotEmpty)
        .forEach((rssItem) {
      rssItemsMap[rssItem.guid!] = rssItem;
    });

    Box<RssItem> rssItemBox = Hive.box<RssItem>(_rssItemBox);
    rssItemBox
        .putAll(rssItemsMap)
        .then(
          (value) => _storage.write(_lastRssUpdate, now.toIso8601String()),
        )
        .then((value) =>
            print('Stored rss items: ${rssItemsMap.length.toString()}'));
  }

  @override
  ValueListenable rssItemsListenable() {
    return Hive.box<RssItem>(_rssItemBox).listenable();
  }
}
