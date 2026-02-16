import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/viewmodels/note_viewmodel.dart';
import 'package:provider/provider.dart';

import 'note_editor_screen.dart';

//@Preview(name: 'Note APP',brightness:Brightness.light,textScaleFactor: 5.0)
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<NoteViewmodel>(context);

    return Consumer<NoteViewmodel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('All Note',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
              centerTitle: true,
            ),
            body:
            Container(
              padding: EdgeInsets.all(12),
              child: vm.notes.isEmpty
                  ? Center(
                child: Text("No saved notes yet", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              )
              
                  : ListView.builder(
                itemCount: vm.notes.length,
                itemBuilder: (_, index) {
                  final note = vm.notes[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// TITLE + ICONS ROW
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  note.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              IconButton(icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NoteEditorScreen(note: note),
                                    ),
                                  );
                                },
                              ),

                              IconButton(icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  if (note.id != null) {
                                    vm.deleteNote(note.id!);
                                  }
                                },
                              ),
                            ],
                          ),

                          /// CONTENT
                          Text(
                            note.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue.shade300,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tooltip: 'Add Note',
              child: Icon(Icons.add,weight: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NoteEditorScreen()),
                );
              },
            ),


          );
        }
    );
  }
}