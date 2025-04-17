import 'package:chat_app/domain/entities/message_entity.dart';

abstract class MessageRepository{
  Future<List<MessageEntity>> fetchMessages(String conservationId);
  Future<void> sendMessage(MessageEntity messageEntity);
}