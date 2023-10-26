import 'package:cuidapet_mobile/app/core/database/migrations/migration.dart';
import 'package:sqflite/sqlite_api.dart';

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
    // TODO: implement update
  }
  
}