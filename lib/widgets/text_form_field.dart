import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function validate;

  const DefaultTextFormField({Key? key, required this.controller, required this.hintText, required this.keyboardType, required this.isPassword, this.suffixIcon, this.prefixIcon, required this.validate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0)
      ),
      validator: (val){
        return validate();
      },
      keyboardType: keyboardType,
      obscureText: isPassword,
    );
  }
}
