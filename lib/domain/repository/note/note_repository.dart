import '../../../data/local/floor/entity/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotes(bool isSortedByCharacter);

  void insertNote(Note note);

  void deleteNote(Note note);

  void updateNote(Note note);

  void clearNotes();
}
