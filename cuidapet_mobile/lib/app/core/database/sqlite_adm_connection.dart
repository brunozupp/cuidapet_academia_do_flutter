// Responsável por fazer a administração da classe de conexão
// que seria um processo para quando o usuário fechar o app
// ele fechar a conexão com o banco de dados, assim evitando
// que o banco/arquivo seja corrompido

import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/material.dart';

class SqliteAdmConnection with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    // Como é um singleton, nem preciso do Modular para pegar a instância
    final connection = SqliteConnectionFactory();
    
    switch(state) {
      
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }
  }
}