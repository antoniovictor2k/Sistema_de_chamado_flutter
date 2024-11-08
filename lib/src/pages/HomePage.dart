import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';
import 'package:sistema_de_chamado/src/components/CustomDescricao.dart';
import 'package:sistema_de_chamado/src/components/CustomDrawer.dart';
import 'package:sistema_de_chamado/src/components/CustomDropdown.dart';
import 'package:sistema_de_chamado/src/components/CustomFilePicker.dart';
import 'package:sistema_de_chamado/src/components/CustomTextField.dart';
import 'package:sistema_de_chamado/services/apiService.dart';
import 'dart:io';

String? email;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController assuntoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  String? selectedCategory;
  String? selectedBranch;

  // Categoria
  final List<String> categorias = [
    'Desktop | Notebook - Configuração',
    'Desktop | Notebook - Instalação',
    'Desktop | Notebook - Lentidão (Anexar Evidência da Ocorrência) (Finalizaremos o Chamado Por Falta do Anexo)',
    'Desktop | Notebook - Manutenção',
    "Desktop | Notebook - Não Liga | Barulho (Anexar Evidência da Ocorrência) (Finalizaremos o Chamado Por Falta do Anexo)",
    "Desktop | Notebook - Orientação",
  ];

// filial
  final List<String> filiais = [
    'CP - Maceió Corporativo',
    'LJ - Arapiraca',
    'CD - Maceió Centro de Distribuição',
    'LJ - Maceió Matriz',
    'LJ - Mangabeiras',
    'LJ - Marechal',
  ];

  // lista de arquivos
  List<String> selectedFiles = [];

  // Função para criar chamado
  Future<void> criarChamado(
      String assunto, mensagem, idUser, category, branch) async {
    final ApiService apiService = ApiService();

    // Converte os caminhos de arquivo String em objetos File
    List<File> files = selectedFiles.map((filePath) => File(filePath)).toList();

    try {
      final returnoFuncao = await apiService.criarChamado(
          assunto, mensagem, idUser, category, branch, files);

      // Verificar se o chamado foi criado com sucesso.

      if (returnoFuncao != "Mensagem de resposta enviada com sucesso!") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("$returnoFuncao \nEntre em contato com o suporte!"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
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
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Erro ao criar chamado: $e");
    }
  }

  @override
  void dispose() {
    assuntoController.dispose();
    descricaoController.dispose();

    super.dispose();
  }

// função para limpar dados preechindos

  void limparDados() {
    setState(() {
      selectedCategory = null;
      selectedBranch = null;
      descricaoController.clear();
      selectedFiles.clear();
      assuntoController.clear();
    });
  }

// Inicio Butão de criar chamado

  Widget _ButaoNovoChamado() {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // Se o teclado estiver visível, retorna um Container vazio
    if (isKeyboardVisible) return Container();

    return Padding(
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
                String assuntoValue = assuntoController.text;
                String descricaoValue = descricaoController.text;

// INICIO IFs de verificação de preechimento

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
                      duration: Duration(seconds: 2),
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
                      duration: Duration(seconds: 2),
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
                      duration: Duration(seconds: 2),
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
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }
// FIM IFs de verificação de preechimento

                // Chame a função criarChamado

                if (assuntoValue != "" &&
                    descricaoValue != "" &&
                    selectedCategory != null &&
                    selectedBranch != null) {
                  criarChamado(assuntoValue, descricaoValue, email!,
                      selectedCategory!, selectedBranch!);
                }
              },
              child: Text(
                "Novo Chamado",
                style: TextStyle(fontSize: 22, color: textColor),
              )),
        ),
      ),
    );
  }

// FIM Butão de criar chamado

// Inicio do corpo da pagina
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
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
                                selectedCategory = newValue;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
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
                                selectedBranch = newValue;
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Butão Escolher Anexo
              CustomFilePicker(
                onFilesSelected: (List<String> files) {
                  setState(() {
                    selectedFiles = files;
                    print(files);
                  });
                },
              ),

              // Butão para limpar campos preechidos
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    limparDados();
                  },
                  child: Text(
                    "Limpar Dados",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  // FIM do corpo da pagina

  @override
  Widget build(BuildContext context) {
    // Recupera os argumentos passados
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = args['email'];

    return Scaffold(
      // INICIO Menu do aplicativo

      drawer: CustomDrawer(
        email: email,
      ),

      // FIM Menu Aplicativo

      // Titulo do Menu

      appBar: AppBar(
        title: Text("Tomticket - Chamado"),
        backgroundColor: primaryColor,
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
