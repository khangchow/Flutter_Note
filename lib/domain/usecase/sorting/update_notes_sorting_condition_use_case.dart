import 'package:flutter_note/domain/repository/sorting_repository.dart';

class UpdateNotesSortingConditionUseCase {
  final SortingRepository sortingRepository;

  UpdateNotesSortingConditionUseCase({required this.sortingRepository});

  void isSortedByCharacter(bool condition) {
    sortingRepository.updateNoteSortingCondition(condition);
  }
}
