import 'package:flutter/material.dart';

import 'package:machine_test_quadleo/core/app_theme/app_colors.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String labelText;
  final bool isObscure;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CommonTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
     this.prefixIcon,
    this.isObscure = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  void toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0XFFF5F5F5),
        prefixIcon:widget.isObscure? Icon(widget.prefixIcon,color: AppColors.grey,):Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("@",style: TextStyle(fontSize: 20,color: AppColors.grey,),),
        ),
        labelText: widget.labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32),borderSide: BorderSide.none),
        suffixIcon: widget.isObscure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,color: AppColors.grey,
                ),
                onPressed: toggleObscure,
              )
            : null,
      ),
    );
  }
}
