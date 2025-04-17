import 'package:chat_app/data/data_sources/auth_remote_data_source.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    return await dataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register(String email, String password, String name) async{
    return await dataSource.register(email: email, password: password, name: name);
  }

}