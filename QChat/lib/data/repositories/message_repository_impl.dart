import 'package:chat_app/data/data_sources/message_remote_data_source.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository{
  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<MessageEntity>> fetchMessages(String conservationId) async{
    return await remoteDataSource.fetMessages(conservationId);
  }

  @override
  Future<void> sendMessage(MessageEntity messageEntity) async{
    throw UnimplementedError();
  }
  
}