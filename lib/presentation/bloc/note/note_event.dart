import '../../../data/local/floor/entity/note.dart';

abstract class NoteEvent {}

class NotesFetched extends NoteEvent {
  final bool isSortedByCharacter;

  NotesFetched({required this.isSortedByCharacter});
}

class NoteInserted extends NoteEvent {
  final Note note;

  NoteInserted({required this.note});
}

class NotesCleared extends NoteEvent {}

class NoteUpdated extends NoteEvent {
  final Note note;

  NoteUpdated({required this.note});
}

class NoteDeleted extends NoteEvent {
  final Note note;

  NoteDeleted({required this.note});
}
