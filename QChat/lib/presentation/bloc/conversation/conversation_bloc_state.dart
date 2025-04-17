import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/conversation_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

abstract class ConversationState{}

class ConversationInitial extends ConversationState{}

class ConversationLoading extends ConversationState{}

class ConversationLoaded extends ConversationState{
  final List<ConversationEntity> conversations;
  final Map<String, UserEntity> users;

  ConversationLoaded(this.conversations, this.users);
}

class ConversationError extends ConversationState{
  final String message;

  ConversationError(this.message);
}