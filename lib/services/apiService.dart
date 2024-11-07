// lib/services/api_service.dart

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';


class ApiService {
  // Método para criar o chamado com anexos
  Future<void> criarChamado(String subject, String message, category, branch, List<File> attachments) async {

    final Uri url = Uri.parse('${baseUrl}new');
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    // Sistema de classificação de software
    final List<Map<String, String>> sistemaSoftwareClassificacao = [
      {
        "id": "72e678e8bfde334b8d9fb7767673b52f",
        'nome': 'Desktop | Notebook - Configuração',
        'equipamento': 'Desktop',
        "classificacao": "Requisição - Solicitação"
      },
      {
        "id": "cde274efbebfe9a73ec18c74bdbdbae9",
        'nome': 'Desktop | Notebook - Instalação',
        'equipamento': 'Desktop',
        "classificacao": "Requisição - Solicitação"
      },
      {
        "id": "ee992ed87a2b15569db3b2ae601abf7d",
        'nome': 'Desktop | Notebook - Lentidão (Anexar Evidência da Ocorrência) (Finalizaremos o Chamado Por Falta do Anexo)',
        'equipamento': 'Desktop',
        "classificacao": "Incidente"
      },
      {
        "id": "633e20a9be4f69eb746cbfa479e6ddf8",
        'nome': 'Desktop | Notebook - Manutenção',
        'equipamento': 'Desktop',
        "classificacao": "Incidente"
      },
      {
        "id": "99b775304018617f6ead0dc12a45aba5",
        'nome': "Desktop | Notebook - Não Liga | Barulho (Anexar Evidência da Ocorrência) (Finalizaremos o Chamado Por Falta do Anexo)",
        'equipamento': 'Desktop',
        "classificacao": "Incidente"
      },
      {
        "id": "90d1c199860ed9e727abaf239aad98a6",
        'nome': "Desktop | Notebook - Orientação",
        'equipamento': 'Desktop',
        "classificacao": "Requisição - Proativo"
      },
    ];

    // Dados do chamado
    final Map<String, String> chamadoData = {
      'customer_id': idUser, // Defina o idUser como necessário
      'department_id': idDepartment, // Defina o idDepartment como necessário
      'subject': subject,
      'message': message,
      'category_id': category, // Defina category como necessário
      'custom_field[0cc0c983628ab9a5d7d1e6bd690bbcc0]': '',
      'custom_field[468245ce8477159f3e7f88cf06f93b6d]': branch,
      'custom_field[dcc9450fa904dc9de1e4e90cf43de37b]': '',
      'custom_field[b70fd313bbfd3e845fb764931641463f]': "TIC - Operações",
      'custom_field[172d91c935e3f929dbb4bab883e98c0e]': "Remoto",
    };

    // Verificando a categoria no sistema de software de classificação
    for (var item in sistemaSoftwareClassificacao) {
      if (item['nome'] == category) {
        chamadoData['category_id'] = item["id"] ?? ''; // Atualizando a categoria
        chamadoData['custom_field[dcc9450fa904dc9de1e4e90cf43de37b]'] = item['equipamento'] ?? ''; // Atualizando equipamento
        chamadoData["custom_field[0cc0c983628ab9a5d7d1e6bd690bbcc0]"] = item['classificacao'] ?? ''; // Atualizando classificação
        break; // Encerra o loop após encontrar uma correspondência
      }
    }

    // Exibe o resultado para verificação
    print(chamadoData);

    // Preparando a requisição para criação do chamado
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields.addAll(chamadoData);

    // Adicionando os anexos à requisição
    for (int i = 0; i < attachments.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'attachment[$i]',
        attachments[i].path,
      ));
    }

    // Enviando a requisição
    final response = await request.send();

    if (response.statusCode == 200) {
      print("Chamado criado com sucesso!");

      // Convertendo a resposta em uma String
      final responseBody = await response.stream.bytesToString();

      // Decodificando a String JSON em um Map
      final parsedResponse = json.decode(responseBody) as Map<String, dynamic>;

      // Vinculando o chamado ao operador
      final Uri vincularChamado = Uri.parse('${baseUrl}operator/link');
      final body = {
        "ticket_id": parsedResponse["ticket_id"].toString(), // ID do ticket
        "operator_id": "76b0d105906063317168fbde1ce837c3" // ID do operador
      };

      var requestVincular = http.MultipartRequest('POST', vincularChamado)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      final responseVincular = await requestVincular.send();

      if (responseVincular.statusCode == 200) {
        print("Chamado vinculado com sucesso!");
      } else {
        print("Falha ao vincular chamado: ${responseVincular.statusCode}");
      }

      // Responder o chamado com uma mensagem automática
      final descricaoResponder = ("Prezado(a),\nRecebemos a sua solicitação e analisaremos em breve. "
          "\n\nAtenciosamente,\nEquipe Central de Serviços - Tecnologia da Informação.");

      final Uri responderChamado = Uri.parse('${baseUrl}reply/operator');
      var requestResponder = http.MultipartRequest('POST', responderChamado)
        ..headers.addAll(headers)
        ..fields.addAll({
          "ticket_id": parsedResponse["ticket_id"].toString(),
          "message": descricaoResponder
        });

      final responseResponder = await requestResponder.send();

      if (responseResponder.statusCode == 200) {
        print("Mensagem de resposta enviada com sucesso!");
      } else {
        print("Falha ao enviar resposta: ${responseResponder.statusCode}");
      }
    } else {
      final responseBody = await response.stream.bytesToString();
      print("Erro ao criar chamado: ${response.statusCode} - $responseBody");
    }
  }
}
