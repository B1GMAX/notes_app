import 'package:flutter/material.dart';
import 'package:notes_app/add_note/add_note_bloc.dart';
import 'package:notes_app/note_list/note_list_page.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AddNoteBloc>(
      create: (context) => AddNoteBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      lazy: false,
      builder: (context, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: context
                            .read<AddNoteBloc>()
                            .noteTextEditingController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.deepPurpleAccent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.deepPurpleAccent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        context.read<AddNoteBloc>().pickImage();
                      },
                      icon: const Icon(Icons.attach_file,
                          color: Colors.deepPurpleAccent, size: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AddNoteBloc>().createNote();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NoteListPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Save note',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
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
