import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  TextInputType keyType;
  Widget? suffIcon;
  bool ? obscureText;


  TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyType,
    this.suffIcon,
    this.obscureText,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? false,
      cursorColor: ColorsManager.lightGrey,
      style: TextStyle(color: ColorsManager.black),
      controller: widget.controller,
      keyboardType: widget.keyType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(
            color: ColorsManager.lightGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(
            color: ColorsManager.lightGrey,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(
            color: ColorsManager.lightGrey,
          ),
        ),
        suffixIcon: widget.suffIcon,
        filled: true,
        fillColor: ColorsManager.white2,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: ColorsManager.lightGrey,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}