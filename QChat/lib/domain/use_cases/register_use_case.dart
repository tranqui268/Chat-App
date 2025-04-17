import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/auth_repository.dart';

class RegisterUseCase{
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity> call(String email, String password, String name){
    return repository.register(email, password, name);
  }
}