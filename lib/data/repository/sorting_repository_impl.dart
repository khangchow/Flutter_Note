import 'package:flutter_note/data/local/sharedpreferences/note_preferences.dart';
import 'package:flutter_note/domain/repository/sorting_repository.dart';

class SortingRepositoryImpl extends SortingRepository {
  @override
  bool isSortedByCharacter() {
    return NotePreferences.isSortedByCharacter();
  }

  @override
  void updateNoteSortingCondition(bool isSortedByCharacter) async {
    await NotePreferences.sortByCharacter(isSortedByCharacter);
  }
}
