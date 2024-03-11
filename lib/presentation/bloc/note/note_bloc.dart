import 'package:bloc/bloc.dart';
import 'package:flutter_note/domain/usecase/note/clear_notes_use_case.dart';
import 'package:flutter_note/domain/usecase/note/delete_note_use_case.dart';
import 'package:flutter_note/domain/usecase/note/insert_note_use_case.dart';
import 'package:flutter_note/domain/usecase/note/update_note_use_case.dart';

import '../../../domain/usecase/note/get_notes_use_case.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotesUseCase getNotesUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final InsertNoteUseCase insertNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final ClearNotesUseCase clearNotesUseCase;

  NoteBloc(
    this.getNotesUseCase,
    this.updateNoteUseCase,
    this.insertNoteUseCase,
    this.deleteNoteUseCase,
    this.clearNotesUseCase,
  ) : super(NoteInitial()) {
    on<NotesFetched>(_getNotes);
    on<NoteInserted>(_insertNote);
    on<NotesCleared>(_clearNotes);
    on<NoteUpdated>(_updateNote);
    on<NoteDeleted>(_deleteNote);
  }

  void _getNotes(NoteEvent event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    final notes =
        getNotesUseCase.invoke((event as NotesFetched).isSortedByCharacter);
    emit(NoteSuccess(notes: notes));
  }

  void _insertNote(NoteEvent event, Emitter<NoteState> emit) {
    insertNoteUseCase.invoke((event as NoteInserted).note);
  }

  void _updateNote(NoteEvent event, Emitter<NoteState> emit) {
    updateNoteUseCase.invoke((event as NoteUpdated).note);
  }

  void _deleteNote(NoteEvent event, Emitter<NoteState> emit) {
    deleteNoteUseCase.invoke((event as NoteDeleted).note);
  }

  void _clearNotes(NoteEvent event, Emitter<NoteState> emit) {
    clearNotesUseCase.invoke();
  }
}
