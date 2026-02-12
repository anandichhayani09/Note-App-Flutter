import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/viewmodels/note_viewmodel.dart';
import 'package:provider/provider.dart';

import 'note_editor_screen.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<NoteViewmodel>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('All Note'),
      ),
      body:
      vm.notes.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_outlined, size: 80, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              "No saved notes yet",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      )


     : ListView.builder(
        itemCount: vm.notes.length,
        itemBuilder: ( _, index) {
          final note = vm.notes[index];

          return ListTile(
            leading: Text('${index + 1}'),
            contentPadding: EdgeInsets.all(10),
            title: Text(note.title),
            subtitle: Text(note.content, maxLines: 1),
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (_) => NoteEditorScreen(note: note),
            //     ),
            //   );
            // },

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteEditorScreen(note: note),
                        ),
                      );
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => vm.deleteNote(note.id!),
                  ),
                ],
              ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteEditorScreen()),
          );
        },
      ),


    );


  }
}