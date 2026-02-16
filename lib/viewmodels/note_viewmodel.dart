import 'package:flutter/cupertino.dart';
import 'package:note_app/repositories/note_repository.dart';
import '../models/note_model.dart';

class NoteViewmodel extends ChangeNotifier{
  final _repo = NoteRepository();
  List<Note> notes = [];

  Future<void> loadNotes() async {
    try {
      notes = await _repo.fetchNotes();
      print("Notes Loaded: ${notes.length}");
      notifyListeners();
    } catch (e) {
      print("LOAD ERROR: $e");
    }
  }


  Future<void> addNote(String title, String content) async {
    await _repo.addNote(Note(title: title, content: content));
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _repo.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _repo.deleteNote(id);
    await loadNotes();
    notifyListeners();
  }

}