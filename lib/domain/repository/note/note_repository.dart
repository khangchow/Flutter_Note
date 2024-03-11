import '../../../data/local/floor/entity/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotes();

  void insertNote(Note note);

  void deleteNote(Note note);

  void updateNote(Note note);

  void clearNotes();

  void updateNoteSortingCondition(bool isSortedByCharacter);
}
