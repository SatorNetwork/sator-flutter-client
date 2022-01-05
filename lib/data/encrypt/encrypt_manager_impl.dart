import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/export.dart';
import 'package:satorio/data/encrypt/ecrypt_manager.dart';

class EncryptManagerImpl extends EncryptManager {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> createRSA() {
    RSAKeyParser().
    return computeRSAKeyPair(getSecureRandom()).then((rsaKey) {
      print("createRSA");
      print(rsaKey.privateKey.toString());
      print(rsaKey.publicKey.toString());
    });
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> computeRSAKeyPair(
    SecureRandom secureRandom,
  ) async {
    return getRsaKeyPair(secureRandom);
    // return await compute(getRsaKeyPair, secureRandom);
  }

  SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    return secureRandom;
  }

  AsymmetricKeyPair<PublicKey, PrivateKey> getRsaKeyPair(
      SecureRandom secureRandom,
      ) {
    var rsapars = new RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
    var params = new ParametersWithRandom(rsapars, secureRandom);
    var keyGenerator = new RSAKeyGenerator();
    keyGenerator.init(params);
    return keyGenerator.generateKeyPair();
  }
}
