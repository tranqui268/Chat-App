import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/use_cases/fetch_message_use_case.dart';
import 'package:chat_app/presentation/bloc/message/message_bloc_event.dart';
import 'package:chat_app/presentation/bloc/message/message_bloc_state.dart';
import 'package:chat_app/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState >{
  final FetchMessageUseCase fetchMessageUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({required this.fetchMessageUseCase}):super(ChatLoadingState()){
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessages);
    on<ReceiveMessageEvent>(_onReceiveMessage);
  }

  Future<void> _onLoadMessages(LoadMessagesEvent event, Emitter<ChatState> emit) async{
    emit(ChatLoadingState());
    try {
      final messages = await fetchMessageUseCase(event.conservationId);
      _messages.clear(); 
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(_messages)));

      _socketService.socket.emit('joinConversation', event.conservationId);
      _socketService.socket.on('newMessage', (data) {
        print("Step 1 - receive : $data");
        add(ReceiveMessageEvent(data));
      });
    } catch (error) {
      emit(ChatErrorState(error.toString())); 
    }

  }

  Future<void> _onSendMessages(SendMessageEvent event, Emitter<ChatState> emit) async{
    String userId = await _storage.read(key: "userId") ?? '';
    print('UserId : $userId');

    final newMessage = {
      'chatId': event.conservationId,
      'senderId': userId,
      'text': event.text,
      'image': [], 
      'video': null,
      'file': null,
    };
    print('Sending message: $newMessage');
    _socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> _onReceiveMessage(ReceiveMessageEvent event, Emitter<ChatState> emit) async{
    print("Step2 - receive event called");
    print(event.message);
    final message = MessageEntity(
      id: event.message['_id'], 
      senderId: event.message['senderId'], 
      conservationId: event.message['chatId'], 
      text: event.message['text'], 
      createdAt: event.message['createdAt']
    );
    _messages.add(message);
    emit(ChatLoadedState(List.from(_messages)));
  }

}