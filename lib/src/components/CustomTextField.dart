import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final double bottom;
 

  CustomTextField({
    required this.labelText,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.bottom = 0.0,
  
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        
        onChanged: onChanged,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: textColor),
          border: InputBorder.none,
          filled: true,
          fillColor: colorInput,
          labelText: labelText,
          hintText: hintText,
          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: bottom,
            left: 15.0,
            right: 15.0,
          ),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
