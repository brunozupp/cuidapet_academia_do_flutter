import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
  
class CuidapetTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;

  CuidapetTextFormField({
    Key? key,
    this.controller,
    this.validator,
    required this.label,
    this.obscureText = false,
  }) : 
  _obscureTextVN = ValueNotifier<bool>(obscureText),
  super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (context, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureTextValue,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            suffixIcon: obscureText
              ? IconButton(
                  onPressed: () {
                    _obscureTextVN.value = !obscureTextValue;
                  }, 
                  icon: Icon(
                    obscureTextValue ? Icons.lock : Icons.lock_open,
                    color: context.primaryColor,
                  ),
                )
              : null,
          ),
        );
      }
    );
  }
}
