import 'package:flutter/material.dart';
import 'package:notes_app/add_note/add_note_bloc.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(create: (context)=> AddNoteBloc(),
    dispose: (context, bloc)=> bloc.dispose(),
      lazy: false,
     child: Scaffold(
       body: Column(
         children: [

         ],
       ),
     ),

    );
  }
}
