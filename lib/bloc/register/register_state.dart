


import 'package:machine_test_quadleo/core/utils/auth_error.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final RegisterError error;

  RegisterFailure(this.error);
}
