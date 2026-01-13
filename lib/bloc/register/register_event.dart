abstract class RegisterEvent {}

class RegisterPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterPressed({required this.email, required this.password});
}
