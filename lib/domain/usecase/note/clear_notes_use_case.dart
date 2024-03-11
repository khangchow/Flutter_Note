import 'package:flutter_note/domain/repository/note/note_repository.dart';

class ClearNotesUseCase {
  final NoteRepository noteRepository;

  ClearNotesUseCase({required this.noteRepository});

  void invoke() {
    noteRepository.clearNotes();
  }
}
