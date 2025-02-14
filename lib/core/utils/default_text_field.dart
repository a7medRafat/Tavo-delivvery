import 'package:flutter/material.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/config/style/app_fonts.dart';

class DefaultField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final String? suffixText;
  final Widget? suffixIconBtn;
  final Widget? suffixTextBtn;
  final Color? suffixIconColor;
  final Color? fillColor;
  final Color? textColor;
  final bool isPassword;
  final TextInputType textInputType;
  final Function()? suffixPressed;
  final validation;
  final Function(String)? onSubmitted;

  final Function(String)? onChanged;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  bool? borderSide = true;
  final bool? isRead;

  DefaultField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isPassword,
    required this.textInputType,
    required this.validation,
    this.suffixPressed,
    this.suffixIcon,
    this.suffixText,
    this.suffixIconColor,
    this.prefixIcon,
    this.suffixIconBtn,
    this.padding,
    this.suffixTextBtn,
    this.onChanged,
    this.borderSide,
    required this.borderRadius,
    this.isRead = false,
    this.onSubmitted,
    this.fillColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isRead!,
      onChanged: onChanged,
      keyboardType: textInputType,
      validator: validation,
      obscureText: isPassword,
      style: AppFonts.bodyText3.copyWith(color: textColor),
      controller: controller,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding:
            padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: borderRadius!),
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffixIcon,
              color: suffixIconColor,
              size: 15,
            )),
        suffixText: suffixText,
        hintText: hint,
        hintStyle: AppFonts.regular1,
        filled: true,
        fillColor: fillColor ?? Colors.white,
      ),
    );
  }
}
