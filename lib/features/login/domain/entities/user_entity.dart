class UserEntity {
  String name, email, user;
  String? imageUrl;
  Map<String, dynamic>? address;
  String subscribeId;

  UserEntity(
      {required this.name,
      required this.email,
      required this.user,
      required this.address,
      required this.imageUrl,
      required this.subscribeId});
}
