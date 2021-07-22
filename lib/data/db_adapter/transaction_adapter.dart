import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/transaction.dart';

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  int get typeId => TransactionTypeId;

  @override
  Transaction read(BinaryReader reader) => Transaction(
        reader.readString(),
        reader.readString(),
        reader.readString(),
        reader.readDouble(),
        DateTime.tryParse(reader.readString()),
      );

  @override
  void write(BinaryWriter writer, Transaction transaction) {
    writer.writeString(transaction.id);
    writer.writeString(transaction.walletId);
    writer.writeString(transaction.txHash);
    writer.writeDouble(transaction.amount);
    writer.writeString(transaction.createdAt?.toIso8601String() ?? '');
  }
}
