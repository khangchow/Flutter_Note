import 'package:flutter/material.dart';
import 'package:flutter_note/data/local/floor/dao/note_dao.dart';
import 'package:flutter_note/data/local/floor/database/note_database.dart';

import '../data/local/sharedpreferences/note_preferences.dart';
import 'note/note_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotePreferences.init();
  final database =
      await $FloorNoteDatabase.databaseBuilder('note_database.db').build();
  final noteDao = database.noteDao;
  runApp(NoteApp(noteDao: noteDao));
}

class NoteApp extends StatelessWidget {
  final NoteDao noteDao;

  const NoteApp({super.key, required this.noteDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: NoteScreen(
        noteDao: noteDao,
      ),
    );
  }
}
