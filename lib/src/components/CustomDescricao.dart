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
        height: 120, // Altura desejada para permitir múltiplas linhas
        padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: 0), // Padding interno
        decoration: BoxDecoration(
          color: colorInput, // Cor de fundo
          borderRadius: BorderRadius.circular(8), // Borda arredondada
        ),
        child: TextField(
          maxLines: null, // Define que o campo pode ter múltiplas linhas
          expands: true, // Expande o TextField para preencher o Container
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none, // Remove a borda padrão do TextField
            labelStyle: TextStyle(color: textColor),
            labelText: "Descrição",
            hintText: "Digite a descrição",
            alignLabelWithHint:
                true, // Alinha o label com o início do texto quando o TextField tem múltiplas linhas
          ),
        ),
      ),
    );
  }
}
