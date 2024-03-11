import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/data/local/floor/dao/note_dao.dart';
import 'package:flutter_note/data/local/floor/database/note_database.dart';
import 'package:flutter_note/data/repository/note_repository_impl.dart';
import 'package:flutter_note/domain/usecase/note/clear_notes_use_case.dart';
import 'package:flutter_note/domain/usecase/note/delete_note_use_case.dart';
import 'package:flutter_note/domain/usecase/note/get_notes_use_case.dart';
import 'package:flutter_note/domain/usecase/note/insert_note_use_case.dart';
import 'package:flutter_note/domain/usecase/note/update_note_use_case.dart';
import 'package:flutter_note/presentation/bloc/note/note_bloc.dart';
import 'package:flutter_note/presentation/screen/note_screen.dart';

import '../data/local/sharedpreferences/note_preferences.dart';

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
    return RepositoryProvider(
      create: (context) => NoteRepositoryImpl(noteDao: noteDao),
      child: BlocProvider(
        create: (context) => NoteBloc(
          GetNotesUseCase(noteRepository: context.read<NoteRepositoryImpl>()),
          UpdateNoteUseCase(noteRepository: context.read<NoteRepositoryImpl>()),
          InsertNoteUseCase(noteRepository: context.read<NoteRepositoryImpl>()),
          DeleteNoteUseCase(noteRepository: context.read<NoteRepositoryImpl>()),
          ClearNotesUseCase(noteRepository: context.read<NoteRepositoryImpl>()),
        ),
        child: MaterialApp(
          title: 'Note',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const NoteScreen(),
        ),
      ),
    );
  }
}
