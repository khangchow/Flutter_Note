import 'package:flutter_note/data/local/floor/entity/note.dart';
import 'package:flutter_note/domain/repository/note_repository.dart';

import '../local/floor/dao/note_dao.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteDao noteDao;

  NoteRepositoryImpl({required this.noteDao});

  @override
  Stream<List<Note>> getNotes(bool isSortedByCharacter) =>
      noteDao.getNotes(isSortedByCharacter);

  @override
  void clearNotes() async {
    await noteDao.deleteAllNotes();
  }

  @override
  void deleteNote(Note note) async {
    await noteDao.deleteNote(note);
  }

  @override
  void insertNote(Note note) async {
    await noteDao.insertNote(note);
  }

  @override
  void updateNote(Note note) async {
    await noteDao.updateNote(note);
  }
}
