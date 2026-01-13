import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_quadleo/bloc/register/register_bloc.dart';
import 'package:machine_test_quadleo/bloc/register/register_event.dart';
import 'package:machine_test_quadleo/bloc/register/register_state.dart';
import 'package:machine_test_quadleo/core/app_theme/app_colors.dart';
import 'package:machine_test_quadleo/core/app_theme/app_textstyles.dart';
import 'package:machine_test_quadleo/core/utils/app_size.dart';
import 'package:machine_test_quadleo/core/utils/app_snackbar.dart';
import 'package:machine_test_quadleo/core/utils/internet_chacker.dart';
import 'package:machine_test_quadleo/core/utils/routes.dart';
import 'package:machine_test_quadleo/widgets/common_button.dart';
import 'package:machine_test_quadleo/widgets/common_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnectivityWrapperWidget(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) async {
              if (state is RegisterSuccess) {
                AppSnackBar.success(context, "Registration successful!");

                final pref = await SharedPreferences.getInstance();
                pref.setBool("in", true);

                Navigator.pushReplacementNamed(context, Routes.homeScreen);
              } else if (state is RegisterFailure) {
                AppSnackBar.error(context, state.error.toString());
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "       Welcome \nCreate an account",
                      style: AppTextstyles.primaryText,
                    ),
                    AppSize.sizedBox(size: 25, isHeight: true),
                    CommonTextFormField(
                       prefixIcon: "assets/images/email_icon.png",
                      controller: emailController,
                      labelText: "Email",
                    ),
                    AppSize.sizedBox(size: 15, isHeight: true),
                    CommonTextFormField(
                      controller: passwordController,
                      labelText: "Password",
                      isObscure: true,
                      prefixIcon:"assets/images/password_icon.png",
                    ),
                    AppSize.sizedBox(size: 32, isHeight: true),
                    state is RegisterLoading
                        ? CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : CommonButton(
                            onTap: () async {
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
                          context,
                          Routes.loginScreen,
                        );
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
      ),
    );
  }
}
