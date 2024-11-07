import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(List<String>) onFilesSelected; // Callback para enviar os arquivos

  CustomFilePicker({required this.onFilesSelected});
  
  @override
  _CustomFilePickerState createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  List<String> filePaths = []; 

  Future<void> pickFiles() async {
    // Usando o FilePicker para escolher arquivos
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true);

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        // Adiciona os novos arquivos à lista de caminhos
        filePaths.addAll(result.files.map((file) => file.path!).toList());
      });
        widget.onFilesSelected(filePaths); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: pickFiles, 
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
              ),
              child: Container(
                width: 70,
                child: Row(
                  children: [
                    Text(
                      "Anexo",
                      style: TextStyle(color: Colors.white), // Cor do texto
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.attachment, color: Colors.white), // Cor do ícone
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Exibe os arquivos selecionados
        ...filePaths.map((path) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                "${path.split('/').last}", 
                style: TextStyle(fontSize: 16),
              ),
            )),
      ],
    );
  }
}
