import 'package:hive/hive.dart';
import 'package:satorio/domain/entities/profile.dart';

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  int get typeId => 0;

  @override
  Profile read(BinaryReader reader) {
    return Profile(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Profile profile) {
    writer.writeString(profile.id);
    writer.writeString(profile.username);
    writer.writeString(profile.firstName);
    writer.writeString(profile.lastName);
  }
}
