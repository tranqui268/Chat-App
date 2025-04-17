import 'package:chat_app/domain/entities/conversation_entity.dart';
import 'package:chat_app/domain/repositories/conversation_repository.dart';

class FetchConversationUseCase{
  final ConversationRepository repository;

  FetchConversationUseCase({required this.repository});

  Future<List<ConversationEntity>> call() async {
    return await repository.fetchConversation();
  }
}