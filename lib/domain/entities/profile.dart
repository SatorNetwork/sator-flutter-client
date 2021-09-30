class Profile {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String avatarPath;

  const Profile(this.id, this.username, this.firstName, this.lastName, this.avatarPath);

  String get displayedName {
    String fullName = '$firstName $lastName'.trim();
    return fullName.isEmpty ? username : fullName;
  }
}
