import 'package:note_app/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db_helper.dart';

class NoteRepository {

  Future<List<Note>> fetchNotes() async {
    final db = await DBHelper().getdatabase();
    final data = await db.query('notes', orderBy: 'id DESC');
    print("Fetched Notes: ${data.length}");

    return data.map((e) => Note.fromMap(e)).toList();

  }

  Future<int> addNote(Note note) async {
    final db = await DBHelper().getdatabase();
    final data = await db.insert('notes', note.toMap());
    return data;
  }

  Future<void> updateNote(Note note) async{
    final db = await DBHelper().getdatabase();
    await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    
  }

  Future<void> deleteNote(int id) async{
    final db = await DBHelper().getdatabase();
    await db.delete('notes',where: 'id = ?',whereArgs: [id]);
  }


}