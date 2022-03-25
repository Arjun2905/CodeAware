import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final Icon prefixIcon;
  final Color color;
  final String label;
  final String hintText;
  final bool obscuretext;
  final TextInputType textInputAction;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  const CustomTextForm({Key? key, required this.prefixIcon, required this.color,
    required this.label, required this.hintText, required this.obscuretext,
    required this.controller, this.validator, this.onSaved,
    required this.textInputAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscuretext,
      onSaved: onSaved,
      validator: validator,
      keyboardType: textInputAction,
      decoration:  InputDecoration(
        hintText: hintText,
        labelText: label,
        prefixIcon: prefixIcon,
      ),
    );
  }
}