import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  factory DBHelper() => instance;

  DBHelper._internal();

  Database? _db;

  Future<Database> getdatabase() async {
    if (_db != null) return _db!;

    _db = await openDatabase('notes.db', version: 1 ,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
        });
    return _db!;
  }

}

