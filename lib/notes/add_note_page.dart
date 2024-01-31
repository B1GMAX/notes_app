import 'package:flutter/material.dart';
import 'package:notes_app/notes/notes_list_bloc.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<NotesBloc>(
      create: (context) => NotesBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      lazy: false,
      builder: (context, _) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<NotesBloc>().pickImage();
                    },
                    icon: Icon(Icons.attach_file),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text(
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
