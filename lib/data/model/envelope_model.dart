import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/envelope.dart';
import 'package:satorio/util/extension.dart';

class EnvelopeModel extends Envelope implements ToJsonInterface {
  const EnvelopeModel(
    String cipherText,
    String cipheredAESKey,
  ) : super(
          cipherText,
          cipheredAESKey,
        );

  factory EnvelopeModel.fromModel(Map json) => EnvelopeModel(
        json.parseValueAsString('ciphertext'),
        json.parseValueAsString('ciphered_aes_key'),
      );

  @override
  Map toJson() => {
        'ciphertext': cipherText,
        'ciphered_aes_key': cipheredAESKey,
      };
}
