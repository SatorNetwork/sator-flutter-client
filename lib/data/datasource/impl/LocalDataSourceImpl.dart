import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/db_adapter/amount_currency_adapter.dart';
import 'package:satorio/data/db_adapter/profile_adapter.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const _profileBox = 'profile';
  static const _walletBox = 'walletBalance';
  static const _wallets = 'wallets';

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(AmountCurrencyAdapter());

    await Hive.openBox<Profile>(_profileBox);
    await Hive.openBox<AmountCurrency>(_walletBox);
  }

  @override
  Future<void> clear() {
    return Hive.box<Profile>(_profileBox)
        .clear()
        .then((value) => Hive.box<AmountCurrency>(_walletBox).clear())
        .then((value) {
      return;
    });
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
  Future<void> saveWallet(List<AmountCurrency> wallet) {
    Box<AmountCurrency> walletBox = Hive.box<AmountCurrency>(_walletBox);
    return walletBox
        .clear()
        .then((value) => walletBox.addAll(wallet))
        .then((value) {
      return;
    });
  }

  @override
  ValueListenable walletListenable() {
    return Hive.box<AmountCurrency>(_walletBox).listenable();
  }
}
