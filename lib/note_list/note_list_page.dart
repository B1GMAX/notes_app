import 'package:flutter/material.dart';
import 'package:notes_app/add_note/add_note_page.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/note_list/note_widget.dart';
import 'package:provider/provider.dart';

import 'notes_list_bloc.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<NotesBloc>(
      create: (BuildContext context) => NotesBloc(),
      builder: (context, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNotePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<List<NoteModel>>(
                    stream: context.read<NotesBloc>().notes,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return NoteWidget(
                                  image: snapshot.data![index].imageUrl,
                                  name: snapshot.data![index].name,
                                  date: snapshot.data![index].date,
                                  id: snapshot.data![index].id ?? '',
                                  onRemove:
                                      context.read<NotesBloc>().removeNote,
                                );
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
