import 'package:flutter/material.dart';

import 'notes_list/note_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFCDC5BD)),
      home: const NoteListPage(),
    );
  }
}