import 'package:chat_app/data/data_sources/user_remote_data_source.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<UserEntity> getUserById(String userId) async{
    return await dataSource.getUserById(userId);
  }}