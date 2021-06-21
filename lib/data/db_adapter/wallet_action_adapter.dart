import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/wallet_action.dart';

class WalletActionAdapter extends TypeAdapter<WalletAction> {
  @override
  int get typeId => WalletActionAdapterTypeId;

  @override
  WalletAction read(BinaryReader reader) => WalletAction(
        reader.readString(),
        reader.readString(),
        reader.readString(),
      );

  @override
  void write(BinaryWriter writer, WalletAction walletAction) {
    writer.writeString(walletAction.type);
    writer.writeString(walletAction.name);
    writer.writeString(walletAction.url);
  }
}
