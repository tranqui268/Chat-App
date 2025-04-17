import 'package:chat_app/domain/entities/user_entity.dart';

abstract class UserRepository{
  Future<UserEntity> getUserById(String userId);
}