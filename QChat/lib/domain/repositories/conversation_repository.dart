import 'package:chat_app/domain/entities/conversation_entity.dart';

abstract class ConversationRepository{
  Future<List<ConversationEntity>> fetchConversation();
}