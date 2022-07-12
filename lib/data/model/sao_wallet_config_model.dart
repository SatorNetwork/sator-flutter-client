import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/sao_wallet_config.dart';
import 'package:satorio/util/extension.dart';

class SaoWalletConfigModel extends SaoWalletConfig implements ToJsonInterface {
  const SaoWalletConfigModel(
    String walletPublicKey,
    String walletPrivateKey,
    String tokenSymbol,
    String tokenMintAddress,
  ) : super(
          walletPublicKey,
          walletPrivateKey,
          tokenSymbol,
          tokenMintAddress,
        );

  factory SaoWalletConfigModel.fromJson(Map json) => SaoWalletConfigModel(
        json.parseValueAsString('wallet_public_key'),
        json.parseValueAsString('wallet_private_key'),
        json.parseValueAsString('token_symbol'),
        json.parseValueAsString('token_mint_address'),
      );

  @override
  Map toJson() => {
        'wallet_public_key': walletPublicKey,
        'wallet_private_key': walletPrivateKey,
        'token_symbol': tokenSymbol,
        'token_mint_address': tokenMintAddress,
      };
}
