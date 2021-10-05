import 'package:hive/hive.dart';
import 'package:satorio/data/db_adapter/adapter_type_ids.dart';
import 'package:satorio/domain/entities/profile.dart';

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  int get typeId => ProfileAdapterTypeId;

  @override
  Profile read(BinaryReader reader) => Profile(
        reader.readString(),
        reader.readString(),
        reader.readString(),
        reader.readString(),
        reader.readString(),
      );

  @override
  void write(BinaryWriter writer, Profile profile) {
    writer.writeString(profile.id);
    writer.writeString(profile.username);
    writer.writeString(profile.firstName);
    writer.writeString(profile.lastName);
    writer.writeString(profile.avatarPath);
  }
}
