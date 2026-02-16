import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import '../models/note_model.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NoteViewmodel>(context, listen: false);
    final bool isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Note" : "Add Note",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              /// TITLE FIELD
              TextFormField(
                controller: titleController,
                decoration: _inputDecoration("Title"),
                validator: _validation,
              ),

              const SizedBox(height: 14),

              /// CONTENT FIELD
              TextFormField(
                controller: contentController,
                maxLines: 5,
                decoration: _inputDecoration("Write note..."),
                validator: _validation,
              ),

              const SizedBox(height: 25),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  child: Text(
                    isEditing ? "Update Note" : "Add Note",
                    style: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {

                    if (_formKey.currentState!.validate()) {

                      if (isEditing) {
                        await vm.updateNote(
                          Note(
                            id: widget.note!.id,
                            title: titleController.text.trim(),
                            content: contentController.text.trim(),
                          ),
                        );
                      } else {
                        await vm.addNote(
                          titleController.text.trim(),
                          contentController.text.trim(),
                        );
                      }

                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// Validation Method
  String? _validation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Fill all fields";
    }
    return null;
  }

  /// Reusable Input Decoration Method
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}

