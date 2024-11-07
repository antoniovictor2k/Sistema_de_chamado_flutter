import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';
import 'package:sistema_de_chamado/src/components/CustomDescricao.dart';
import 'package:sistema_de_chamado/src/components/CustomDrawer.dart';
import 'package:sistema_de_chamado/src/components/CustomDropdown.dart';
import 'package:sistema_de_chamado/src/components/CustomFilePicker.dart';
import 'package:sistema_de_chamado/src/components/CustomTextField.dart';
import 'package:sistema_de_chamado/services/apiService.dart';
import 'dart:io'; // Importante para usar a classe File

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController assuntoController =
      TextEditingController(); // Armazenar o valor do assunto
  final TextEditingController descricaoController =
      TextEditingController(); // Armazenar o valor do e-mail
  

  String? selectedCategory; // Variável para armazenar o valor da categoria
  String? selectedBranch; // Variável para armazenar o valor da filial

  // Lista de opções para os dropdowns
  final List<String> categorias = [
    'Desktop | Notebook - Configuração',
    'Desktop | Notebook - Instalação',
    'Desktop | Notebook - Lentidão (Anexar Evidência da Ocorrência) (Finalizaremos o Chamado Por Falta do Anexo)',
    'Desktop | Notebook - Manutenção',
    "Desktop | Notebook - Não Liga | Barulho (Anexar Evidência da Ocorrência) (Finalizaremos o Chamado Por Falta do Anexo)",
    "Desktop | Notebook - Orientação",
  ];

  final List<String> filiais = [
    'CP - Maceió Corporativo',
    'LJ - Arapiraca',
    'CD - Maceió Centro de Distribuição',
    'LJ - Maceió Matriz',
    'LJ - Mangabeiras',
    'LJ - Marechal',
  ];

  List<String> selectedFiles = [];

  // INICIO Escolher arquivos

  // FIM Escolher arquivos

  // Função para criar chamado
  Future<void> criarChamado(
      String assunto, String mensagem, String category, String branch) async {
    final ApiService apiService = ApiService();

    // Converte os caminhos de arquivo String em objetos File
    List<File> files = selectedFiles.map((filePath) => File(filePath)).toList();

    try {
      await apiService.criarChamado(assunto, mensagem, category, branch, files);
      print("Chamado criado com sucesso!");
    } catch (e) {
      print("Erro ao criar chamado: $e");
    }
  }

   @override
  void dispose() {
    assuntoController.dispose(); // Libera o controlador ao finalizar o widget
    descricaoController.dispose(); // Libera o controlador ao finalizar o widget
    
    super.dispose();
  }

  void limparDados() {
    setState(() {
      selectedCategory = null; // Ou selectedCategory = ""; para limpar
      selectedBranch = null; // Ou selectedBranch = ""; para limpar
      descricaoController.clear();
      selectedFiles.clear();
      assuntoController.clear();
    });
  }


  Widget _ButaoNovoChamado() {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // Se o teclado estiver visível, retorna um Container vazio
    if (isKeyboardVisible) return Container();

    return // INICIO Butão para criar novo chamado
        Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                // Obtendo os valores dos controladores
                String assuntoValue = assuntoController.text;
                String descricaoValue = descricaoController.text;

                if (assuntoValue == "") {
                   ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: textColor,
                          content: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Digite o assunto!",
                                style: TextStyle(
                                  color: colorInput,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(
                              seconds:
                                  2), // Tempo que o SnackBar ficará visível
                        ),
                      );
                      return;
                }
                if (selectedCategory == null) {
                   ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: textColor,
                          content: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Escolhar a categoria!",
                                style: TextStyle(
                                  color: colorInput,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(
                              seconds:
                                  2), // Tempo que o SnackBar ficará visível
                        ),
                      );
                      return;
                }

                if (selectedBranch == null) {
                   ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: textColor,
                          content: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Escolhar a filial!",
                                style: TextStyle(
                                  color: colorInput,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(
                              seconds:
                                  2), // Tempo que o SnackBar ficará visível
                        ),
                      );
                      return;
                }

                if (descricaoValue == "") {
                   ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: textColor,
                          content: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Digite a Descrição!",
                                style: TextStyle(
                                  color: colorInput,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(
                              seconds:
                                  2), // Tempo que o SnackBar ficará visível
                        ),
                      );
                      return;
                }

                // Chame a função criarChamado
                if (assuntoValue != "" && descricaoValue != "" && selectedCategory != null && selectedBranch != null) {  
                criarChamado(assuntoValue, descricaoValue, selectedCategory!,
                    selectedBranch!); // Use parênteses para invocar a função
                }else{
                   ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: textColor,
                          content: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Erro ao criar chamado, tente novamente!",
                                style: TextStyle(
                                  color: colorInput,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(
                              seconds:
                                  2), // Tempo que o SnackBar ficará visível
                        ),
                      );
                }

                // Exibindo os valores no console
                print(
                    "Assunto: $assuntoValue, \nDescrição: $descricaoValue, \nCategoria: $selectedCategory, \nFilial: $selectedBranch \nAnexos: $selectedFiles");
                print("Novo Chamado");

                showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Sucesso"),
      content: Text("Chamado criado com sucesso!"),
      actions: <Widget>[
        TextButton(
          child: Text("OK"),
          onPressed: () {
            limparDados();
            Navigator.of(context).pop(); // Fecha o diálogo
            
          },
        ),
      ],
    );
  },
);


              },
              child: Text(
                "Novo Chamado",
                style: TextStyle(fontSize: 22, color: textColor),
              )),
        ),
      ),
    );

    // FIM Butão para criar novo chamado
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),

          // Campos Assunto
          CustomTextField(
            labelText: "Assunto:",
            hintText: "Digite o Assunto",
            controller: assuntoController,
            keyboardType: TextInputType.text,
            
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinha os filhos à esquerda
              children: [
                // Campos Categoria

                Container(
                  decoration: BoxDecoration(
                    color: colorInput,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Espaço entre os widgets
                      children: [
                        Align(
                          alignment:
                              Alignment.center, // Alinha o título à esquerda
                          child: Text(
                            'Categoria:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: CustomDropdown(
                            items: categorias,
                            selectedValue: selectedCategory,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory =
                                    newValue; // Atualiza o valor selecionado
                              });
                            },
                            hint: 'Selecione a Categoria',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 4),

                // INICIO Campos Filial

                Container(
                  decoration: BoxDecoration(
                    color: colorInput,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Espaço entre os widgets
                      children: [
                        Align(
                          alignment:
                              Alignment.center, // Alinha o título à esquerda
                          child: Text(
                            'Filial:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: CustomDropdown(
                            items: filiais,
                            selectedValue: selectedBranch,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedBranch =
                                    newValue; // Atualiza o valor selecionado
                              });
                            },
                            hint: 'Selecione a Filial',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // FIM Campos Filial

          // INICIO Campos Descrição

          CustomDescricao(
            controller: descricaoController,
          ),

          // FIM Campos Descrição

          // // INICIO Escolher Anexo

          CustomFilePicker(
            onFilesSelected: (List<String> files) {
              setState(() {
                selectedFiles = files;
                print(files);
              });
            },
          ),

          // // FIM Escolher Anexo
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

      // Recupera os argumentos passados
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = args['email']; // Pega o e-mail dos argumentos


    return Scaffold(
      // INICIO Menu do aplicativo

      drawer: CustomDrawer(email: email,),

      // FIM Menu Aplicativo

      // Titulo do Menu

      appBar: AppBar(
        title: Text("Tomticket - Chamado"),
        backgroundColor: primaryColor, // Altera a cor de fundo da AppBar
      ),

      // Corpo da pagina

      body: Stack(
        children: [
          Container(
            color: backgroundColor,
          ),
          _body(),
          Align(alignment: Alignment.bottomCenter, child: _ButaoNovoChamado())
        ],
      ),
    );
  }
}
