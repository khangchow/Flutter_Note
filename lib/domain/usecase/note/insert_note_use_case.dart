import 'package:flutter_note/domain/repository/note/note_repository.dart';

import '../../../data/local/floor/entity/note.dart';

class InsertNoteUseCase {
  final NoteRepository noteRepository;

  InsertNoteUseCase({required this.noteRepository});

  void invoke(Note note) {
    noteRepository.insertNote(note);
  }
}
