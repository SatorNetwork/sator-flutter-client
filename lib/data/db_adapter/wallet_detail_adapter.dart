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
        reader.readList() as List<AmountCurrency>,
        reader.readList() as List<WalletAction>,
      );

  @override
  void write(BinaryWriter writer, WalletDetail walletDetail) {
    writer.writeString(walletDetail.id);
    writer.writeString(walletDetail.solanaAccountAddress);
    writer.writeList(walletDetail.balance);
    writer.writeList(walletDetail.actions);
  }
}
