
import 'package:chat_app/domain/use_cases/login_use_case.dart';
import 'package:chat_app/domain/use_cases/register_use_case.dart';
import 'package:chat_app/presentation/bloc/auth/auth_bloc_event.dart';
import 'package:chat_app/presentation/bloc/auth/auth_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = FlutterSecureStorage();

  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()){
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);

  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    try {
      final user = await registerUseCase(event.email, event.password, event.name);
      emit(AuthSuccess(message: "Registration Successful")); 
    } catch (e) {
      print(e.toString());
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async{
     emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      print(user.token);
      await _storage.write(key: 'token', value: user.token );
      await _storage.write(key: 'userId', value: user.id);
      emit(AuthSuccess(message: "Login Successful")); 
    } catch (e) {
      print(e.toString());
      emit(AuthFailure(error: e.toString()));
    }

  }
}