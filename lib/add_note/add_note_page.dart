import 'package:flutter/material.dart';
import 'package:notes_app/add_note/add_note_bloc.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AddNoteBloc>(
      create: (context) => AddNoteBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: context.read<AddNoteBloc>().pickImage,
                  child: StreamBuilder(
                    stream: context.read<AddNoteBloc>().fileImageStream,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                snapshot.data!,
                                height: 90,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Text(
                              'Choose image',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurpleAccent),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller:
                      context.read<AddNoteBloc>().noteTextEditingController,
                  decoration: InputDecoration(
                    hintText: 'Input note name...',
                    hintStyle: const TextStyle(fontSize: 14),
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
                const SizedBox(height: 20),
                StreamBuilder<bool>(
                  initialData: false,
                  stream: context.read<AddNoteBloc>().isNoteSavedStream,
                  builder: (context, snapshot) {
                    return !snapshot.data!
                        ? SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                final isSuccess = await context
                                    .read<AddNoteBloc>()
                                    .createNote();
                                if (isSuccess && context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Save note',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
