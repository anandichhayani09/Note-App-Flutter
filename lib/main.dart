import 'package:flutter/material.dart';
import 'package:note_app/viewmodels/note_viewmodel.dart';
import 'package:note_app/views/notes_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI for Desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final vm = NoteViewmodel();
  await vm.loadNotes();

  runApp(
    ChangeNotifierProvider.value(
      value: vm,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  NotesScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("All Notes"),
//
//       ),
//       body: Container()
//       ,
//
//
//     );
//   }
// }





