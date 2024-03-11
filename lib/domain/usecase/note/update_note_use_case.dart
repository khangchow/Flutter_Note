import 'package:flutter_note/domain/repository/note/note_repository.dart';

import '../../../data/local/floor/entity/note.dart';

class UpdateNoteUseCase {
  final NoteRepository noteRepository;

  UpdateNoteUseCase({required this.noteRepository});

  void invoke(Note note) {
    noteRepository.updateNote(note);
  }
}
