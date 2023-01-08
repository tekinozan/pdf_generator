import 'package:flutter/material.dart';
import 'package:pdf_generator/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.black),
              borderRadius: BorderRadius.circular(50)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.5, color: Colors.black),
              borderRadius: BorderRadius.circular(50)
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          label: Center(
            child: Text(labelText!,style: TextStyle(color: Colors.grey),),
          )
        ),
      ),
    );
  }
}
