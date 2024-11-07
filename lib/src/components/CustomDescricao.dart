import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';

class CustomDescricao extends StatelessWidget {
  final TextEditingController? controller;

  const CustomDescricao({this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: Container(
        height: 120, 
        padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: 0), 
        decoration: BoxDecoration(
          color: colorInput, 
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          maxLines: null, 
          expands: true, 
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none, 
            labelStyle: TextStyle(color: textColor),
            labelText: "Descrição",
            hintText: "Digite a descrição",
            alignLabelWithHint:
                true, 
          ),
        ),
      ),
    );
  }
}
