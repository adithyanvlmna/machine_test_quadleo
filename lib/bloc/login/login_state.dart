


import 'package:machine_test_quadleo/core/utils/auth_error.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final LoginError error;

  LoginFailure(this.error);
}
