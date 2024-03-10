import 'package:floor/floor.dart';
import 'package:flutter_note/data/local/floor/entity/note.dart';

@dao
abstract class NoteDao {
  Stream<List<Note>> getNotes(bool isSortedByCharacter) {
    return isSortedByCharacter
        ? getNotesSortedByTitleAscending()
        : getNotesSortedByCreatedTimeAscending();
  }

  @Query('SELECT * FROM note ORDER BY title ASC')
  Stream<List<Note>> getNotesSortedByTitleAscending();

  @Query('SELECT * FROM note ORDER BY createdAt ASC')
  Stream<List<Note>> getNotesSortedByCreatedTimeAscending();

  @Query('DELETE FROM note')
  Future<void> deleteAllNotes();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @update
  Future<void> updateNote(Note note);
}
