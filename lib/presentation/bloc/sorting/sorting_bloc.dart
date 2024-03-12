import 'package:bloc/bloc.dart';
import 'package:flutter_note/presentation/bloc/sorting/sorting_event.dart';

import '../../../domain/usecase/sorting/is_sorted_by_character_use_case.dart';
import '../../../domain/usecase/sorting/update_notes_sorting_condition_use_case.dart';

class SortingBloc extends Bloc<SortingEvent, bool> {
  final IsSortedByCharacterUseCase isSortedByCharacterUseCase;
  final UpdateNotesSortingConditionUseCase updateNotesSortingConditionUseCase;

  SortingBloc(
    this.isSortedByCharacterUseCase,
    this.updateNotesSortingConditionUseCase,
  ) : super(isSortedByCharacterUseCase.invoke()) {
    on<SortingConditionChanged>(_updateNotesSortingCondition);
  }

  void _updateNotesSortingCondition(SortingEvent event, Emitter<bool> emit) {
    final isSortedByCharacter =
        (event as SortingConditionChanged).isSortedByCharacter;
    updateNotesSortingConditionUseCase.isSortedByCharacter(isSortedByCharacter);
    emit(isSortedByCharacter);
  }
}
