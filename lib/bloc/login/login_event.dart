abstract class LoginEvent {}

class LoginPressed extends LoginEvent {
  final String email;
  final String password;

  LoginPressed({required this.email, required this.password});
}
