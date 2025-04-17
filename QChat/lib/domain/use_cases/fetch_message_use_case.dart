import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';

class FetchMessageUseCase{
  final MessageRepository messageRepository;
  
  FetchMessageUseCase({required this.messageRepository});

  Future<List<MessageEntity>> call(String conservationId) async{
    return await messageRepository.fetchMessages(conservationId);
  }
}