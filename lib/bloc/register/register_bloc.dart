import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/core/utils/auth_error.dart';
import 'package:machine_test_quadleo/service/firebase_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterPressed>((event, emit) async {
      emit(RegisterLoading());

      final error = await FirebaseService.signUp(
        emailAddress: event.email,
        password: event.password,
      );

      if (error == RegisterError.noError) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(error));
      }
    });
  }
}
