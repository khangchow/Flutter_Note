import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String title;
  String description;
  int createdAt;

  Note(
      {this.id,
      required this.title,
      required this.description,
      required this.createdAt});
}
