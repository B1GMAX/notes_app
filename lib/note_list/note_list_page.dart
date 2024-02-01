import 'package:flutter/material.dart';
import 'package:notes_app/add_note/add_note_page.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:provider/provider.dart';

import 'notes_list_bloc.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<NotesBloc>(
      lazy: false,
      create: (BuildContext context) => NotesBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<List<NoteModel>>(
                    initialData: const [],
                    stream: context.read<NotesBloc>().getAllNotes(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                Text(snapshot.data![index].name, style: const TextStyle(color: Colors.black),),
                                const SizedBox(width: 15),
                                Image.network(snapshot.data![index].imageUrl,),
                              ],
                            ),
                          );
                        },
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
