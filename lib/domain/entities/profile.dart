class Profile {
  final String id;
  final String username;
  final String firstName;
  final String lastName;

  const Profile(this.id, this.username, this.firstName, this.lastName);

  String get displayedName {
    String fullName = '$firstName $lastName'.trim();
    return fullName.isEmpty ? username : fullName;
  }
}
