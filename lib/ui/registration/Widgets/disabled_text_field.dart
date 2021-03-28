import 'package:flutter/material.dart';
import 'package:rcmasbusapp/app_theme.dart';

class DisabledTextField extends StatelessWidget {
  DisabledTextField({required String hint, String? text})
      : _hint = hint,
        _text = text;
  final String _hint;
  final String? _text;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: _text ?? ''),
      decoration: InputDecoration(
          border: border,
          enabled: false,
          focusedBorder: border,
          disabledBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: _hint),
    );
  }
}
