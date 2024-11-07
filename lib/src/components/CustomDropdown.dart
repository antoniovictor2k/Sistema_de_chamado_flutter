import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items; // Lista de itens do dropdown
  final String? selectedValue; // Valor atualmente selecionado
  final ValueChanged<String?> onChanged; // Callback para o valor selecionado
  final String hint; // Texto de dica quando nenhuma opção é selecionada

  // Construtor
  CustomDropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hint = 'Selecione uma opção',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      hint: Text(hint),
      isExpanded: true,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item,
          //  overflow: TextOverflow.ellipsis, // Adiciona reticências se o texto for muito longo
          ),
          
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: colorInput,
      iconEnabledColor: textColor,
      underline: SizedBox()
    );
  }
}