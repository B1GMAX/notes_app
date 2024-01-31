import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final List<NoteModel> notes = [];

  final BehaviorSubject<List<NoteModel>> _noteModelListController =
      BehaviorSubject();

  Stream<List<NoteModel>> get noteModelListStream =>
      _noteModelListController.stream;

  Future<void> pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        print('image - $image; image path - ${File(image.path)}');
      }
    } on PlatformException catch(e){
      print('Faild to pick image - $e');
    }
  }

  void dispose() {}
}
