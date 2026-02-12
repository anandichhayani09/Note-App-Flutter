import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import '../models/note_model.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  NoteEditorScreen({this.note});

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
final titleController = TextEditingController();
final contentController = TextEditingController();

@override
void initState() {
  super.initState();
  if (widget.note != null) {
    titleController.text = widget.note!.title;
    contentController.text = widget.note!.content;
  }
}

@override
Widget build(BuildContext context) {
  final vm = Provider.of<NoteViewmodel>(context, listen: false);

  return Scaffold(
    appBar: AppBar(title: Text("Note")),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(hintText: "Title")),
            SizedBox(height: 10),
            TextField(controller: contentController, decoration: InputDecoration(hintText: "Write note..."), maxLines: 6),
            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {
                if (widget.note == null) {
                  await vm.addNote(titleController.text, contentController.text,);
                  print("Note Added");
                } else {
                  await vm.updateNote(Note(
                    id: widget.note!.id,
                    title: titleController.text,
                    content: contentController.text,
                  ));
                }

                Navigator.pop(context);
              },

            )
          ],
        ),
      ),
    ),
  );
}
}
