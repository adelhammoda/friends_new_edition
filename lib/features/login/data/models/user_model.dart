import 'package:friends/features/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.name,
      required super.email,
      required super.user,
      required super.address,
      required super.imageUrl,
      required super.subscribeId});


  ///this function take [Map] of json
  ///and convert it to [UserModel].
  factory UserModel.fromJson(Map json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        user: json['user'],
        address: json['address'],
        imageUrl: json['image_url'],
        subscribeId: json['subscribe_id']);
  }

  ///take all parameters in class
  ///and convert them to [Map]
  Map<String , dynamic> toJson(){
    return {
      'name':name,
      'email':email,
      'user':user,
      'address':address,
      'image_url':imageUrl,
      'subscribe_id':subscribeId
    };
  }

}
