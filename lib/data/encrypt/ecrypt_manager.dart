abstract class EncryptManager {
  Future<String> createRSAgetPublicKey();

  Future<String> encrypt(String serverPublicKey, String plainText);

  Future<String> decrypt(String data);
}
