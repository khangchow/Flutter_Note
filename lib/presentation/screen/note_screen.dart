import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/data/local/sharedpreferences/note_preferences.dart';
import 'package:flutter_note/presentation/bloc/note/note_bloc.dart';
import 'package:flutter_note/presentation/bloc/note/note_event.dart';
import 'package:flutter_note/presentation/bloc/note/note_state.dart';

import '../../data/local/floor/entity/note.dart';
import 'add_edit_note_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

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
    context
        .read<NoteBloc>()
        .add(NotesFetched(isSortedByCharacter: isSortedByCharacter));
  }

  void _handleCheckboxChanged() {
    setState(() {
      context
          .read<NoteBloc>()
          .add(NotesFetched(isSortedByCharacter: isSortedByCharacter));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  context.read<NoteBloc>().add(NotesCleared());
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
              return const AddEditNoteScreen();
            }),
          );
        },
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteSuccess) {
            return StreamBuilder(
              stream: state.notes,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                final List<Note> notes = snapshot.data ?? List.empty();
                return ListView.separated(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    Note note = notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return AddEditNoteScreen(
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
              },
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
