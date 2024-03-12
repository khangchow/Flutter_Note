import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/presentation/bloc/note/note_bloc.dart';
import 'package:flutter_note/presentation/bloc/note/note_event.dart';
import 'package:flutter_note/presentation/bloc/sorting/sorting_bloc.dart';

import '../../data/local/floor/entity/note.dart';
import '../bloc/sorting/sorting_event.dart';
import 'add_edit_note_screen.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(NotesFetched(
          isSortedByCharacter: context.read<SortingBloc>().state,
        ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: StatefulBuilder(
                  builder: (context, setState) =>
                      BlocBuilder<SortingBloc, bool>(
                    builder: (context, state) {
                      return CheckboxListTile(
                        value: state,
                        activeColor: Colors.blue,
                        onChanged: (value) async {
                          context.read<SortingBloc>().add(
                              SortingConditionChanged(
                                  isSortedByCharacter: value!));
                          setState(() {});
                          context
                              .read<NoteBloc>()
                              .add(NotesFetched(isSortedByCharacter: value));
                        },
                        title: const Text('Sort by character ASC'),
                      );
                    },
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
      body: BlocBuilder<NoteBloc, Stream<List<Note>>>(
        builder: (context, state) {
          return StreamBuilder(
            stream: state,
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
        },
      ),
    );
  }
}
