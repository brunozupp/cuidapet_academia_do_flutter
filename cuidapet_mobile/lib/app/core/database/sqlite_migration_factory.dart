import 'package:cuidapet_mobile/app/core/database/migrations/migration.dart';
import 'package:cuidapet_mobile/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {

  List<Migration> getCreateMigrations() => [
    MigrationV1(),
  ];

  List<Migration> getUpdateMigrations(int oldVersion) {

    // if(oldVersion == 2) {
    //   return [V1,V2];
    // }

    return [];
  }

  // Supondo que o app está na versão 3 e eu na versão 1 ainda
  // List<Migration> getUpdateMigrations(int oldVersion) {

    // Não peguei as coisas da versão 2, então preciso dela na lista
    // if(oldVersion == 1) {
    //   return [V2,V3];
    // }

    // if(oldVersion == 2) {
    //   return [V3];
    // }

  // Representa a versão atual
  //   return [];
  // }

  // Supondo que o app está na versão 7 e eu na versão 3 ainda
  // Terei que executar as migrations das versões 4, 5, 6 e 7
  // List<Migration> getUpdateMigrations(int oldVersion) {

    // if(oldVersion == 1) {
    //   return [V2,V3,V4,V5,V6,V7];
    // }

    // if(oldVersion == 2) {
    //   return [V3,V4,V5,V6,V7];
    // }

    // if(oldVersion == 3) {
    //   return [V4,V5,V6,V7];
    // }

    // if(oldVersion == 4) {
    //   return [V5,V6,V7];
    // }

    // if(oldVersion == 5) {
    //   return [V6,V7];
    // }

    // if(oldVersion == 6) {
    //   return [V7];
    // }

  // Representa a versão 
  //   return [];
  // }
}