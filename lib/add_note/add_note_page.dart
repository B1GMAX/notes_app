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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 18),
                  Expanded(
                    child: TextField(
                      controller:
                          context.read<AddNoteBloc>().noteTextEditingController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AddNoteBloc>().pickImage();
                    },
                    icon: const Icon(Icons.attach_file),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
