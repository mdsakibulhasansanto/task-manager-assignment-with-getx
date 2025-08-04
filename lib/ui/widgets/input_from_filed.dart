

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class InputFromFiled extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;

  const InputFromFiled({
    super.key,
    required this.controller,
    required this.hint,
    this.inputType = TextInputType.text,

  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      cursorColor: AppColors.themeColor,

      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter ${hint.toLowerCase()}';
        }
        return null;
      },
    );
  }
}
