import 'package:bloc/bloc.dart';
import 'package:machine_test_quadleo/core/utils/auth_error.dart';
import 'package:machine_test_quadleo/service/firebase_service.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPressed>((event, emit) async {
      emit(LoginLoading());

      final error = await FirebaseService.signIn(
        emailAddress: event.email,
        password: event.password,
      );

      if (error == LoginError.noError) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error));
      }
    });
  }
}
