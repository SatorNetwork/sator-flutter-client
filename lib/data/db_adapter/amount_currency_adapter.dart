import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/amount_currency.dart';

class AmountCurrencyAdapter extends TypeAdapter<AmountCurrency> {
  @override
  int get typeId => AmountCurrencyAdapterTypeId;

  @override
  AmountCurrency read(BinaryReader reader) => AmountCurrency(
        reader.readDouble(),
        reader.readString(),
      );

  @override
  void write(BinaryWriter writer, AmountCurrency amountCurrency) {
    writer.writeDouble(amountCurrency.amount);
    writer.writeString(amountCurrency.currency);
  }
}
