import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/use_cases/fetch_conversation_use_case.dart';
import 'package:chat_app/domain/use_cases/get_user_by_id.dart';
import 'package:chat_app/presentation/bloc/conversation/conversation_bloc_event.dart';
import 'package:chat_app/presentation/bloc/conversation/conversation_bloc_state.dart';
import 'package:chat_app/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState>{
  final FetchConversationUseCase fetchConversationsUseCase;
  final GetUserById getUserById;
  final SocketService _socketService = SocketService();


  ConversationBloc({required this.fetchConversationsUseCase, required this.getUserById}) :super(ConversationInitial()){
    on<FetchConversations>(_onFetchConversation);
    _initializeSocketListeners();

  }

  void _initializeSocketListeners(){
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated); 
    } catch (e) {
      print("Error initializing socket listeners : $e"); 
    }
  }

  Future<void> _onFetchConversation(FetchConversations event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    try {
      final conversations = await fetchConversationsUseCase();
      Map<String, UserEntity> users = {};
      for (var conversation in conversations) {
        final user = await getUserById.getUserById(conversation.members[1]);
        users[conversation.members[1]] = user;        
      }
      emit(ConversationLoaded(conversations, users));
    } catch (e) {
      print(e);
      emit(ConversationError(e.toString()));
    }

  }

  void _onConversationUpdated(data){
    add(FetchConversations());
  }
  
}