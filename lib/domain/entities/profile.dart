class Profile {
  final String id;
  final String firstName;
  final String lastName;

  const Profile(this.id, this.firstName, this.lastName);

  String get fullName => firstName + lastName;
}
