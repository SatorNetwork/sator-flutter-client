import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/wallet.dart';

class WalletAdapter extends TypeAdapter<Wallet> {
  @override
  int get typeId => WalletAdapterTypeId;

  @override
  Wallet read(BinaryReader reader) => Wallet(
        reader.readString(),
        reader.readString(),
        reader.readString(),
      );

  @override
  void write(BinaryWriter writer, Wallet wallet) {
    writer.writeString(wallet.id);
    writer.writeString(wallet.detailsUrl);
    writer.writeString(wallet.transactionsUrl);
  }
}
