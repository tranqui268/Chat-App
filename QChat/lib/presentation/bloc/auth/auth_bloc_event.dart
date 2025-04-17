abstract class AuthEvent {

}

class RegisterEvent extends AuthEvent{
  final String email;
  final String password;
  final String name;

  RegisterEvent({required this.email, required this.name, required this.password});
}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}