import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.maxLines,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.prefixIcon,
      this.validator,
      this.obscureText,
      this.borderColor,
      this.textColor,
      this.errorText,
      this.suffixIcon,
      this.onChanged})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final Color? borderColor;
  final Color? textColor;
  final int? maxLines;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller!,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: textColor,
        ),
        errorText: errorText,
        errorStyle: TextStyle(color: textColor, fontSize: 15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor!,
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor!,
              width: 2,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor!,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor!,
            width: 2,
          ),
        ),
      ),
    );
  }
}
