import 'package:flutter/material.dart';
import 'package:sistema_de_chamado/src/pages/HomePage.dart';
import 'package:sistema_de_chamado/src/pages/LoginPage.dart';


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    theme: ThemeData(
   primarySwatch: Colors.blue, 
    brightness: Brightness.dark
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Loginpage(),
      '/home': (context) => Homepage(),
    },
   );
  }
  
}