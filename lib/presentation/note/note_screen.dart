import 'package:flutter/material.dart';
import 'package:flutter_note/data/local/sharedpreferences/note_preferences.dart';
import 'package:flutter_note/presentation/add_note/add_edit_note_screen.dart';

import '../../data/local/floor/dao/note_dao.dart';
import '../../data/local/floor/entity/note.dart';

class NoteScreen extends StatefulWidget {
  final NoteDao noteDao;

  const NoteScreen({super.key, required this.noteDao});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late bool isSortedByCharacter;
  int count = 0;

  @override
  void initState() {
    super.initState();
    isSortedByCharacter = NotePreferences.isSortedByCharacter();
  }

  void _handleCheckboxChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('build $isSortedByCharacter');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: StatefulBuilder(
                  builder: (context, setState) => CheckboxListTile(
                    value: isSortedByCharacter,
                    activeColor: Colors.blue,
                    onChanged: (value) async {
                      isSortedByCharacter = value ?? false;
                      await NotePreferences.sortByCharacter(
                          isSortedByCharacter);
                      setState(() {});
                      _handleCheckboxChanged();
                    },
                    title: const Text('Sort by character ASC'),
                  ),
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  await widget.noteDao.deleteAllNotes();
                },
                child: const Text('Delete all notes'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddEditNoteScreen(
                noteDao: widget.noteDao,
              );
            }),
          );
        },
      ),
      body: StreamBuilder<List<Note>>(
        stream: widget.noteDao.getNotes(isSortedByCharacter),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Note> notes = snapshot.data!;
            return ListView.separated(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Note note = notes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return AddEditNoteScreen(
                          noteDao: widget.noteDao,
                          note: note,
                        );
                      }),
                    );
                  },
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                    // Add more UI components here as needed
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
