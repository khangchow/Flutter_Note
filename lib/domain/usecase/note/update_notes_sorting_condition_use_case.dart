import '../../repository/note/note_repository.dart';

class UpdateNotesSortingConditionUseCase {
  final NoteRepository noteRepository;

  UpdateNotesSortingConditionUseCase({required this.noteRepository});

  void invoke(bool isSortedByCharacter) {
    noteRepository.updateNoteSortingCondition(isSortedByCharacter);
  }
}
