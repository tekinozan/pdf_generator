import 'package:flutter/material.dart';
import 'package:pdf_generator/utils/colors.dart';

class EditPageTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final double? width;
  final Icon? icon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;

  const EditPageTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.icon,
    this.onTap,
    this.width,
    this.keyboardType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300,
      child: TextFormField(
        onTap: onTap,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          labelText: labelText,
          hintText: hintText,
          icon: icon,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2.5, color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
