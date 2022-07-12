import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/sao_wallet.dart';

class SaoWalletAdapter extends TypeAdapter<SaoWallet> {
  @override
  int get typeId => SaoWalletTypeId;

  @override
  SaoWallet read(BinaryReader reader) => SaoWallet(
        reader.readString(),
        reader.readString(),
        reader.readString(),
        reader.readString(),
        reader.readDouble(),
      );

  @override
  void write(BinaryWriter writer, SaoWallet saoWallet) {
    writer.writeString(saoWallet.walletPublicKey);
    writer.writeString(saoWallet.walletPrivateKey);
    writer.writeString(saoWallet.tokenSymbol);
    writer.writeString(saoWallet.tokenMintAddress);
    writer.writeDouble(saoWallet.amount);
  }
}
