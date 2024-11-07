import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String hint;

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
            child: Text(
              item,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: colorInput,
        iconEnabledColor: textColor,
        underline: SizedBox());
  }
}
