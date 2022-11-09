import 'package:codigolimpionetforemost/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Este metódo que esta basado con la libreria de SQLite,
//y solo es soportada para dispositivos Android, IOS y MacOs.
class SqliteService {
  //Abre y crea base de datos en SQLite.
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'note_database.db'),
        onCreate: (db, version) {
      //Crea la base de datos.
      return db.execute(
        "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, nameNote TEXT, date TEXT, note TEXT)",
      );
    }, version: 1);
  }

//Metódo para insertar datos en la database notas.
  static Future<Future<int>> insert(Notes notas) async {
    //Manda a llamar a la database.
    Database database = await _openDB();
    //Inserta los datos en la db.
    return database.insert("notes", notas.toMap());
  }

//Metódo para actualizar datos,
  static Future<Future<int>> update(Notes notas) async {
    //Manda a llamar a la database.
    Database database = await _openDB();
    //Actualiza los datos segun "ID" de la database notas.
    return database.update(
      "notes",
      notas.toMap(),
      where: "id = ?",
      whereArgs: [notas.id],
    );
  }

  static Future<List<Notes>> notas(String orderByX) async {
    //Manda a llamar a la database y ordena por X valor(notas o fechas).
    Database database = await _openDB();
    final List<Map<String, dynamic>> notasMap = await database.query(
      "notes",
      orderBy: orderByX,
    );
    //Genera una lista con los datos obtenidos.
    return List.generate(
        notasMap.length,
        (i) => Notes(
            id: notasMap[i]['id'],
            nameNote: notasMap[i]['nameNote'],
            date: notasMap[i]['date'],
            note: notasMap[i]['note']));
  }
}
