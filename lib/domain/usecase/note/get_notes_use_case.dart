import 'package:flutter_note/domain/repository/note/note_repository.dart';

import '../../../data/local/floor/entity/note.dart';

class GetNotesUseCase {
  final NoteRepository noteRepository;

  GetNotesUseCase({required this.noteRepository});

  Stream<List<Note>> invoke() => noteRepository.getNotes();
}
