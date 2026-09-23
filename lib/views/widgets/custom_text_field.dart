import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  
    CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    required TextInputAction textInputAction, this.suffixIcon,
  });
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
    final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final Widget? suffixIcon;
  bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.onEditingComplete,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
      suffixIcon: widget.suffixIcon,
      ),
      validator: widget.validator,
    );
  }
}
