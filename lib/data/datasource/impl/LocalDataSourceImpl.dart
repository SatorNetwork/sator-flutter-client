import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/db_adapter/amount_currency_adapter.dart';
import 'package:satorio/data/db_adapter/profile_adapter.dart';
import 'package:satorio/data/db_adapter/wallet_action_adapter.dart';
import 'package:satorio/data/db_adapter/wallet_adapter.dart';
import 'package:satorio/data/db_adapter/wallet_detail_adapter.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/wallet.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const _profileBox = 'profile';
  static const _walletBalanceBox = 'walletBalance';
  static const _walletBox = 'wallet';
  static const _walletDetailBox = 'walletDetail';

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(AmountCurrencyAdapter());
    Hive.registerAdapter(WalletAdapter());
    Hive.registerAdapter(WalletActionAdapter());
    Hive.registerAdapter(WalletDetailAdapter());

    await Hive.openBox<Profile>(_profileBox);
    await Hive.openBox<AmountCurrency>(_walletBalanceBox);
    await Hive.openBox<Wallet>(_walletBox);
    await Hive.openBox<WalletDetail>(_walletDetailBox);
  }

  @override
  Future<void> clear() async {
    await Hive.box<Profile>(_profileBox).clear();
    await Hive.box<AmountCurrency>(_walletBalanceBox).clear();
    await Hive.box<Wallet>(_walletBox).clear();
    await Hive.box<WalletDetail>(_walletDetailBox).clear();
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
    Box<Wallet> walletsBox = Hive.box<Wallet>(_walletBox);
    wallets.forEach((wallet) {
      walletsBox.put(wallet.id, wallet);
    });
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
  ValueListenable walletDetailsListenable(List<String> ids) {
    return Hive.box<WalletDetail>(_walletDetailBox).listenable(keys: ids);
  }
}
