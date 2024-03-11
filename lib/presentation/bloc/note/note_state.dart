import 'package:flutter/foundation.dart';

import '../../../data/local/floor/entity/note.dart';

@immutable
abstract class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteSuccess extends NoteState {
  final Stream<List<Note>> notes;

  NoteSuccess({required this.notes});
}
