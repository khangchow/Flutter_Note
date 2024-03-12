import 'package:flutter_note/domain/repository/sorting_repository.dart';

class IsSortedByCharacterUseCase {
  final SortingRepository sortingRepository;

  IsSortedByCharacterUseCase({required this.sortingRepository});

  bool invoke() {
    return sortingRepository.isSortedByCharacter();
  }
}
