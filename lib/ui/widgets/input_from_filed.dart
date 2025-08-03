

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
