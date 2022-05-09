import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_action.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';

class WalletDetailAdapter extends TypeAdapter<WalletDetail> {
  @override
  int get typeId => WalletDetailAdapterTypeId;

  @override
  WalletDetail read(BinaryReader reader) => WalletDetail(
        reader.readString(),
        reader.readString(),
        reader.readInt(),
        reader.readList().map((e) => e as AmountCurrency).toList(),
        reader.readList().map((e) => e as WalletAction).toList(),
        reader.readString(),
      );

  @override
  void write(BinaryWriter writer, WalletDetail walletDetail) {
    writer.writeString(walletDetail.id);
    writer.writeString(walletDetail.solanaAccountAddress);
    writer.writeInt(walletDetail.order);
    writer.writeList(walletDetail.balance);
    writer.writeList(walletDetail.actions);
    writer.writeString(walletDetail.type);
  }
}
