import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';

class CustomDrawer extends StatefulWidget {
  final String? email;

  const CustomDrawer({this.email, super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String emailUser; // Declare a variável

  @override
  void initState() {
    super.initState();
    emailUser =
        widget.email ?? ''; // Inicializa a variável usando o valor do widget
  }

  String formatarNome(String emailUser) {
    // Extrai a parte do e-mail antes do domínio
    String namePart = emailUser.split('@')[0]; // "antonio.seveirano"

    // Divide pelo ponto para obter o primeiro e segundo nome
    List<String> names = namePart.split('.');

    // Capitaliza o primeiro e o segundo nome e combina
    String firstName = names[0][0].toUpperCase() + names[0].substring(1);
    String secondName = names.length > 1
        ? names[1][0].toUpperCase() + names[1].substring(1)
        : "";

    return "$firstName $secondName";
  }

  @override
  Widget build(BuildContext context) {
    // Utilize o email conforme necessário
    String nomeUser = formatarNome(emailUser);

    return Drawer(
      backgroundColor: colorInput,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              currentAccountPicture: Icon(
                Icons.person,
                size: 50,
              ),
              accountName: Text(nomeUser),
              accountEmail: Text(emailUser)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Inicio"),
                    subtitle: Text("Tela de Inicio"),
                    onTap: () {
                      setState(() {
                        print("Home");
                      });
                      print("Home Print");
                      Navigator.of(context).pushReplacementNamed("/home");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Sobre"),
                    subtitle: Text("Sobre o aplicativo"),
                    onTap: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Atenção"),
                              content: Text("Esta opção esta desativada!"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Fecha o diálogo
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                      // Navigator.of(context).pushReplacementNamed("/");
                    },
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout,
                        color: textColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Sair",
                        style: TextStyle(color: textColor, fontSize: 22),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      // Define borda arredondada
                      borderRadius:
                          BorderRadius.circular(8), // Tamanho do raio da borda
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Developer by Antonio Victor",
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
