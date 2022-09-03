class UserEntity {
  String name, email, user, imageUrl;
  Map<String, dynamic> address;
  String subscibeId;

  UserEntity(
      {required this.name,
        required this.email,
        required this.user,
        required this.address,
        required this.imageUrl,
        required this.subscibeId});
}
