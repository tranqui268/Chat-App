import 'package:chat_app/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.id, required super.name, required super.email, required super.avatar, required super.token, required super.password, required super.isOnline, required super.lastActive});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['_id'], 
      name: json['name'], 
      email: json['email'], 
      password: json['password'] ?? '',
      avatar: json['avatar'] ?? '',
      isOnline: json['isOnline'] ?? false,
      lastActive: json['lastActive'] ?? '',
      token: json['token'] ?? ''
    );
  }
  
}