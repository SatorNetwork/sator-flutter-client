import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:satorio/data/encrypt/ecrypt_manager.dart';

class EncryptManagerImpl extends EncryptManager {
  static const String KEY_PRIVATE = 'RSA_PRIVATE';
  static const String KEY_PUBLIC = 'RSA_PUBLIC';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<String> createRSAgetPublicKey() async {
    final KeyPair keyPair = await RSA.generate(256 * 8);

    await _secureStorage.write(key: KEY_PRIVATE, value: keyPair.privateKey);

    await _secureStorage.write(key: KEY_PUBLIC, value: keyPair.publicKey);

    final result = await RSA.convertPublicKeyToPKIX(keyPair.publicKey);

    return result;
  }
}
