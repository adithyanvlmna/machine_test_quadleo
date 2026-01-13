import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/bloc/login/login_bloc.dart';
import 'package:machine_test_quadleo/bloc/login/login_event.dart';
import 'package:machine_test_quadleo/bloc/login/login_state.dart';
import 'package:machine_test_quadleo/core/app_theme/app_textstyles.dart';
import 'package:machine_test_quadleo/core/utils/app_size.dart';
import 'package:machine_test_quadleo/core/utils/app_snackbar.dart';
import 'package:machine_test_quadleo/core/utils/form_validator.dart';
import 'package:machine_test_quadleo/core/utils/internet_chacker.dart';
import 'package:machine_test_quadleo/core/utils/routes.dart';
import 'package:machine_test_quadleo/widgets/common_button.dart';
import 'package:machine_test_quadleo/widgets/common_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final forKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityWrapperWidget(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                AppSnackBar.success(context, "Login Successfully");
                final pref = await SharedPreferences.getInstance();
                pref.setBool("in", true);
                print(pref.getBool("in"));
                Navigator.pushReplacementNamed(context, Routes.homeScreen);
              } else if (state is LoginFailure) {
                AppSnackBar.error(context, state.error.toString());
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Form(
                  key: forKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome back!", style: AppTextstyles.primaryText),
                      AppSize.sizedBox(size: 25, isHeight: true),
                      CommonTextFormField(
                        validator: (val) => validator(val, fieldName: "Email"),
                        prefixIcon: "assets/images/email_icon.png",
                        controller: emailController,
                        labelText: "Email",
                      ),
                      AppSize.sizedBox(size: 15, isHeight: true),
                      CommonTextFormField(
                        validator: (val) =>
                            validator(val, fieldName: "Password"),
                        controller: passwordController,
                        labelText: "Password",
                        isObscure: true,
                        prefixIcon: "assets/images/password_icon.png",
                      ),
                      AppSize.sizedBox(size: 32, isHeight: true),
                      state is LoginLoading
                          ? CircularProgressIndicator()
                          : CommonButton(
                              onTap: () async {
                                if (forKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(
                                    LoginPressed(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              buttonText: "Sign in",
                            ),
                      AppSize.sizedBox(size: 15, isHeight: true),
                      CommonButton(
                        onTap: () {},
                        buttonText: "Forgot password?",
                        isWhite: true,
                      ),
                      AppSize.sizedBox(size: 15, isHeight: true),
                      CommonButton(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.registerScreen);
                        },
                        buttonText: "Create Account",
                        isWhite: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
