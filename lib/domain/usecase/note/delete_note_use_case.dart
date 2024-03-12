import '../../../data/local/floor/entity/note.dart';
import '../../repository/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository noteRepository;

  DeleteNoteUseCase({required this.noteRepository});

  void invoke(Note note) {
    noteRepository.deleteNote(note);
  }
}
