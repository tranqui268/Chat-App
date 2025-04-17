import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';

class GetUserById{
  final UserRepository repository;

  GetUserById({required this.repository});

  Future<UserEntity> getUserById(String userId) async{
    return await repository.getUserById(userId);

  }
}