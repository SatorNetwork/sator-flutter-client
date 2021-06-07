import 'dart:async';

import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:satorio/data/datasource/local_data_source.dart';
import 'package:satorio/data/db_adapter/profile_adapter.dart';
import 'package:satorio/domain/entities/profile.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const _profileBox = 'profile';

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProfileAdapter());

    await Hive.openBox<Profile>(_profileBox);
  }

  @override
  Future<void> clear() {
    return Hive.box<Profile>(_profileBox).clear().then((value) {
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
}
