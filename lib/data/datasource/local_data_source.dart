import 'package:flutter/foundation.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';

abstract class LocalDataSource {
  Future<void> init();

  Future<void> clear();

  Future<void> saveProfile(Profile profile);

  ValueListenable profileListenable();

  Future<void> saveWallet(List<AmountCurrency> wallet);

  ValueListenable walletListenable();
}
