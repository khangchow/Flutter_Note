abstract class SortingEvent {}

class SortingConditionChanged extends SortingEvent {
  final bool isSortedByCharacter;

  SortingConditionChanged({required this.isSortedByCharacter});
}
