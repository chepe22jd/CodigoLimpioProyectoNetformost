import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:codigolimpionetforemost/models/note.dart';

class SqliteService {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'nota_database.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE notas (id INTEGER PRIMARY KEY AUTOINCREMENT, nombreNota TEXT, fecha TEXT, nota TEXT)",
      );
    }, version: 1);
  }

  static Future<Future<int>> insert(Notas notas) async {
    Database database = await _openDB();

    return database.insert("notas", notas.toMap());
  }

  static Future<Future<int>> update(Notas notas) async {
    Database database = await _openDB();

    return database
        .update("notas", notas.toMap(), where: "id = ?", whereArgs: [notas.id]);
  }

  static Future<List<Notas>> notas() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> notasMap = await database.query("notas");

    return List.generate(
        notasMap.length,
        (i) => Notas(
            id: notasMap[i]['id'],
            nombreNota: notasMap[i]['nombreNota'],
            fecha: notasMap[i]['fecha'],
            nota: notasMap[i]['nota']));
  }
}
