import 'package:flutter/foundation.dart';
import 'package:satorio/domain/entities/profile.dart';

abstract class LocalDataSource {
  Future<void> init();

  Future<void> clear();

  Future<void> saveProfile(Profile profile);

  ValueListenable profileListenable();
}
