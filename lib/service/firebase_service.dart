import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test_quadleo/core/utils/auth_error.dart';

class FirebaseService {
  static Future<RegisterError> signUp({
  required String emailAddress,
  required String password,
}) async {
  RegisterError error = RegisterError.noError;

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress.trim(),
      password: password.trim(),
    );
  } on FirebaseAuthException catch (e) {
    print("Firebase Error: ${e.code}");

    if (e.code == 'weak-password') {
      error = RegisterError.weakPassword;
    } else if (e.code == 'email-already-in-use') {
      error = RegisterError.alreadyExists;
    } else if (e.code == 'invalid-email') {
      error = RegisterError.invalidEmail;
    }
  } catch (e) {
    print("Unknown error: $e");
  }

  return error;
}


static Future<LoginError> signIn({
  required String emailAddress,
  required String password,
}) async {
  LoginError error = LoginError.noError;

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress.trim(),
      password: password.trim(),
    );
  } on FirebaseAuthException catch (e) {
    print("Firebase Login Error: ${e.code}");

    if (e.code == 'user-not-found') {
      error = LoginError.userNotFound;
    } else if (e.code == 'invalid-credential') {
      error = LoginError.invalidCredentia;
    } else if (e.code == 'invalid-email') {
      error = LoginError.invalidEmail;
    }
  } catch (e) {
    print("Unknown error: $e");
  }

  return error;
}

}
