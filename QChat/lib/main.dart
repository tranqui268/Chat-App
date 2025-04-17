import 'package:chat_app/data/data_sources/auth_remote_data_source.dart';
import 'package:chat_app/data/data_sources/conversation_remote_data_source.dart';
import 'package:chat_app/data/data_sources/message_remote_data_source.dart';
import 'package:chat_app/data/data_sources/user_remote_data_source.dart';
import 'package:chat_app/data/repositories/auth_repositpry_impl.dart';
import 'package:chat_app/data/repositories/conversation_repository_impl.dart';
import 'package:chat_app/data/repositories/message_repository_impl.dart';
import 'package:chat_app/data/repositories/user_repository_impl.dart';
import 'package:chat_app/domain/use_cases/fetch_conversation_use_case.dart';
import 'package:chat_app/domain/use_cases/fetch_message_use_case.dart';
import 'package:chat_app/domain/use_cases/get_user_by_id.dart';
import 'package:chat_app/domain/use_cases/login_use_case.dart';
import 'package:chat_app/domain/use_cases/register_use_case.dart';
import 'package:chat_app/presentation/bloc/auth/auth_bloc_bloc.dart';
import 'package:chat_app/presentation/bloc/conversation/conversation_bloc_bloc.dart';
import 'package:chat_app/presentation/bloc/message/message_bloc_bloc.dart';
import 'package:chat_app/presentation/screen/onboarding_screen.dart';
import 'package:chat_app/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();
  final authRepository = AuthRepositoryImpl(dataSource: AuthRemoteDataSource());
  final conversationRepository = ConversationRepositoryImpl(dataSource: ConversationRemoteDataSource());
  final  userRepository = UserRepositoryImpl(dataSource: UserRemoteDataSource());
  final messageRepository = MessageRepositoryImpl(remoteDataSource: MessageRemoteDataSource());
  runApp(
    MyApp(
      authrepository: authRepository, 
      conversationRepository: conversationRepository, 
      userRepository: userRepository,
      messageRepository: messageRepository,
      )
  );
}

class MyApp extends StatelessWidget{
  final AuthRepositoryImpl authrepository;
  final ConversationRepositoryImpl conversationRepository;
  final UserRepositoryImpl  userRepository;
  final MessageRepositoryImpl messageRepository;
  const MyApp({
    Key? key, 
    required this.authrepository, 
    required this.conversationRepository, 
    required this.userRepository,
    required this.messageRepository
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authrepository), 
            loginUseCase: LoginUseCase(repository: authrepository)
          )
        ),
        BlocProvider(
          create: (_) => ConversationBloc(
            fetchConversationsUseCase : FetchConversationUseCase(repository: conversationRepository),
            getUserById: GetUserById(repository: userRepository)
            )
        ),
        BlocProvider(
          create: (_) => ChatBloc(
            fetchMessageUseCase: FetchMessageUseCase(messageRepository: messageRepository)
            )
        )
      ], 
      child:  const MaterialApp(
      title: 'Onboarding Screen',
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    )

    );
  }

}