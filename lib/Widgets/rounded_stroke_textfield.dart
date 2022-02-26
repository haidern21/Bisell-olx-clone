import 'package:flutter/material.dart';

class RoundedStrokeTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextStyle? style;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool? obscureText;
  final Color? strokeColor;
  final String? errorText;

   const RoundedStrokeTextField(
      {Key? key, this.keyboardType,
      this.textInputAction,
      this.hintText,
      this.errorText,
      this.focusNode,
      this.obscureText,
      this.strokeColor,
      this.maxLength,
      this.style,
      this.onChanged}) : super(key: key);

  @override
  _RoundedStrokeTextFieldState createState() => _RoundedStrokeTextFieldState();
}

class _RoundedStrokeTextFieldState extends State<RoundedStrokeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: TextField(
        obscureText: widget.obscureText ?? false,
        style: widget.style,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          errorText: (widget.errorText!.isEmpty) ? null : widget.errorText,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorMaxLines: 2,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.red),
          ),
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
        ),
        maxLength: widget.maxLength,
      ),
    );
  }
}
