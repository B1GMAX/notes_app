import 'package:flutter/material.dart';
import 'package:notes_app/notes_list/notes_list_bloc.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      lazy: false,
      create: (BuildContext context) => NotesListBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              // Expanded(child: ListView.builder(itemBuilder: )),
            ],
          ),
        ),
      ),
    );
  }
}
