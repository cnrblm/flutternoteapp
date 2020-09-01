import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, "notebook.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)");
    print("Table is created");
  }

  //insertion
  Future<int> saveUser(Note note) async {
    var dbClient = await db;
    int res = await dbClient.insert("Notes", note.toMap());
    print(res);
    return res;
  }

  Future<List<Note>> getAll() async {
    // Get a reference to the database.
    var dbClient = await db;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await dbClient.query("Notes");
    print(maps);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Note.fromDb(maps[i]['id'], maps[i]['title'], maps[i]['content']);
    });
  }

  //deletion
  Future<int> removeNote(int id) async {
    var dbClient = await db;
    int res = await dbClient.delete("Notes", where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
