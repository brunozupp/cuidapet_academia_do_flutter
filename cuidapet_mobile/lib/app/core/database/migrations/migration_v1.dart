import 'package:cuidapet_mobile/app/core/database/migrations/migration.dart';
import 'package:sqflite/sqlite_api.dart';

// A partir da versão 2, toda criação que eu fizar no método "create"
// vou precisar aplicar no método update também, pois o método create só executa uma única vez
// quando o app é aberto pela primeira vez (quando a conexão é aberta pela primeira vez).
// Então se eu criei uma nova tabela no método create na V2, preciso aplicar a mesma criação da tabela
// no método de update da V2.

class MigrationV1 implements Migration {

  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE addresses (
        id Integer primary key autoincrement,
        address text not null,
        lat text,
        lng text,
        additional text
      )
    ''');
  }

  @override
  void update(Batch batch) {
    
  }
  
}