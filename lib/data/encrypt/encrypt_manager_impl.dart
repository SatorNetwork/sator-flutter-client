import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as crypto;
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:satorio/data/encrypt/ecrypt_manager.dart';
import 'package:satorio/data/model/envelope_model.dart';

class EncryptManagerImpl extends EncryptManager {
  static const String KEY_PRIVATE = 'RSA_PRIVATE';
  static const String KEY_PUBLIC = 'RSA_PUBLIC';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String> _privateKey() async {
    return (await _secureStorage.read(key: KEY_PRIVATE))!;
  }

  Future<String> _publicKey() async {
    return (await _secureStorage.read(key: KEY_PUBLIC))!;
  }

  @override
  Future<String> createRSAgetPublicKey() async {
    final KeyPair keyPair = await RSA.generate(256 * 8);

    await _secureStorage.write(key: KEY_PRIVATE, value: keyPair.privateKey);
    await _secureStorage.write(key: KEY_PUBLIC, value: keyPair.publicKey);

    final result = await RSA.convertPublicKeyToPKIX(keyPair.publicKey);

    return result;
  }

  @override
  Future<String> decrypt(String data) async {
    final EnvelopeModel envelope = EnvelopeModel.fromModel(json.decode(data));

    final String privateKey = await _privateKey();

    final Uint8List aesKeyUint = await RSA.decryptOAEPBytes(
      base64.decode(envelope.cipheredAESKey),
      '',
      Hash.SHA512,
      privateKey,
    );

    final algorithm = crypto.AesGcm.with256bits(nonceLength: 12);
    final decryptedResult = await algorithm.decrypt(
      crypto.SecretBox.fromConcatenation(
        base64.decode(envelope.cipherText),
        nonceLength: 12,
        macLength: 16,
      ),
      secretKey: crypto.SecretKey(aesKeyUint.toList()),
    );
    return  utf8.decode(decryptedResult);
  }

  @override
  Future<String> encrypt(
    String serverPublicKey,
    String plainText,
  ) async {
    final cipher = crypto.AesGcm.with256bits(nonceLength: 12);
    final aesKey = await cipher.newSecretKey();
    final secretBox = await cipher.encrypt(
      plainText.codeUnits,
      secretKey: aesKey,
    );

    List<int> summaryBytes = [];
    summaryBytes.addAll(secretBox.nonce);
    summaryBytes.addAll(secretBox.cipherText);
    summaryBytes.addAll(secretBox.mac.bytes);

    final aesBytes = await aesKey.extractBytes();
    final Uint8List cipheredAESKeyUint = await RSA.encryptOAEPBytes(
      Uint8List.fromList(aesBytes),
      '',
      Hash.SHA512,
      serverPublicKey,
    );

    return json.encode(
      EnvelopeModel(
        base64.encode(summaryBytes),
        base64.encode(cipheredAESKeyUint.toList()),
      ).toJson(),
    );
  }
}
