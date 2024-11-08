import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/Style/theme.dart';
import 'package:sistema_de_chamado/src/components/CustomTextField.dart';
import 'package:sistema_de_chamado/src/data/data.dart';
import 'package:flutter/services.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override

// limpar quando a tela for alterada

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Logo

          Container(
            width: 382,
            height: 100,
            child: Image.asset("assets/imagens/logologin.png"),
          ),
          SizedBox(
            height: 70,
          ),

          // Inicio Input E-mail

          CustomTextField(
            labelText: "E-mail:",
            hintText: "Digite seu e-mail",
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),

          // FIM Input E-mail

          // INICIO Input Senha
          CustomTextField(
            labelText: "Senha:",
            hintText: "Digite sua senha",
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: senhaController,
          ),
          // Fim Input Senha

          // Altura de 10
          SizedBox(
            height: 10,
          ),

          // INICIO Butão entrar
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, bottom: 0.0, left: 15.0, right: 15.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    String emailValue = emailController.text;
                    String senhaValue = senhaController.text;

                    if (users.contains(emailValue) &&
                        senhaValue == "Carajas@2024") {
                      Navigator.of(context).pushReplacementNamed("/home",
                          arguments: {"email": emailValue});
                    } else {
                     
                      // Exibe o SnackBar em caso de login inválido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: textColor,
                          content: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "E-mail e/ou senha inválido(s)!",
                                style: TextStyle(
                                  color: colorInput,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 22, color: textColor),
                  )),
            ),
          ),

          // FIM Butão entrar
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Cor de Fundo
          Container(
            color: backgroundColor,
          ),
          
          // corpo da pagina
          _body(),

          // Texto fixo na parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Central 82 4009-2299",
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
