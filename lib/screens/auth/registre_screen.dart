import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/bloc/register/register_bloc.dart';
import 'package:machine_test_quadleo/bloc/register/register_event.dart';
import 'package:machine_test_quadleo/bloc/register/register_state.dart';
import 'package:machine_test_quadleo/core/app_theme/app_colors.dart';
import 'package:machine_test_quadleo/core/app_theme/app_textstyles.dart';
import 'package:machine_test_quadleo/core/utils/app_size.dart';
import 'package:machine_test_quadleo/core/utils/routes.dart';
import 'package:machine_test_quadleo/widgets/common_button.dart';
import 'package:machine_test_quadleo/widgets/common_textfield.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Registration successful!")),
              );
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error.toString())),
              );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("       Welcome \nCreate an account",
                      style: AppTextstyles.primaryText),
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
                  state is RegisterLoading
                      ? CircularProgressIndicator(color: AppColors.primaryColor,)
                      : CommonButton(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                                  RegisterPressed(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                          buttonText: "Register",
                        ),
                  AppSize.sizedBox(size: 15, isHeight: true),
                  CommonButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginScreen);
                    },
                    buttonText: "Back to Login",
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

