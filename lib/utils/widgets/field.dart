import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class Field extends StatefulWidget {
  Field({
    super.key,
    required this.text,
    required this.validateText,
    required this.obscureText,
    required this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onFieldSubmitted,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.expands = false,
  });

  final Function(String)? onFieldSubmitted;
  final dynamic controller;
  final String text;
  final String validateText;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  int? maxLines;
  final bool obscureText;
  final bool readOnly;
  final bool expands;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFormField(
        onChanged: widget.onChanged,
        expands: widget.expands,
        maxLines: widget.expands ? null : widget.maxLines,
        minLines: null,
        obscureText: widget.obscureText,
        cursorHeight: 27,
        cursorColor: kMainColor,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        onFieldSubmitted: (val) => widget.onFieldSubmitted!(val),
        validator: (text) {
          if (text == null || text == "") {
            return widget.validateText;
          }
          return null;
        },
        style: const TextStyle(height: 1),
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          label: Text(widget.text),
        ),
      ),
    );
  }
}
