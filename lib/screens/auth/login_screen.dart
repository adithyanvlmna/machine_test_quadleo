import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/bloc/login/login_bloc.dart';
import 'package:machine_test_quadleo/bloc/login/login_event.dart';
import 'package:machine_test_quadleo/bloc/login/login_state.dart';
import 'package:machine_test_quadleo/core/app_theme/app_textstyles.dart';
import 'package:machine_test_quadleo/core/utils/app_size.dart';
import 'package:machine_test_quadleo/core/utils/routes.dart';
import 'package:machine_test_quadleo/widgets/common_button.dart';
import 'package:machine_test_quadleo/widgets/common_textfield.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error.toString())),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome back!", style: AppTextstyles.primaryText),
                  AppSize.sizedBox(size: 25, isHeight: true),
                  CommonTextFormField(
                    controller: emailController,
                    labelText: "Email",
                  ),
                  AppSize.sizedBox(size: 15, isHeight: true),
                  CommonTextFormField(
                    controller: passwordController,
                    labelText: "Password",
                    isObscure: true,
                    prefixIcon: Icons.key,
                  ),
                  AppSize.sizedBox(size: 32, isHeight: true),
                  state is LoginLoading
                      ? CircularProgressIndicator()
                      : CommonButton(
                          onTap: () {
                            context.read<LoginBloc>().add(
                                  LoginPressed(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
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
              );
            },
          ),
        ),
      ),
    );
  }
}
