import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/local/floor/dao/note_dao.dart';
import '../../data/local/floor/entity/note.dart';

class AddEditNoteScreen extends StatelessWidget {
  final Note? note;
  final NoteDao noteDao;

  const AddEditNoteScreen({super.key, this.note, required this.noteDao});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note?.title ?? "");
    final descriptionController =
        TextEditingController(text: note?.description ?? "");
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              Visibility(
                visible: note != null,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Last update: ${note != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(note!.createdAt)) : ''}',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Title can not be empty!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      if (note == null) {
                        noteDao.insertNote(
                          Note(
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Inserted new note.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        note!.title = titleController.text.trim();
                        note!.description = descriptionController.text.trim();
                        note!.createdAt = DateTime.now().millisecondsSinceEpoch;
                        noteDao.updateNote(note!);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(note == null ? 'Add' : 'Edit'),
                  ),
                  Visibility(
                    visible: note != null,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text(
                                  'Do you really want to delete this note?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    noteDao.deleteNote(note!);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Deleted!'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog when the "Close" button is pressed
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Delete'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
