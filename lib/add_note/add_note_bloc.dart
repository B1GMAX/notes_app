import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/models/note_model.dart';

class AddNoteBloc {
  final noteTextEditingController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();

  AddNoteBloc() {
    final data = storageRef.child("images/");
    print('dataaaaaaaa - ${data}');
  }

  String imageName = '';
  late File image;

  void createNote() async {
    final imageUrl = await _uploadFile();
    final NoteModel note = NoteModel(
      name: noteTextEditingController.text.trim(),
      date: DateTime.now().toString(),
      imageUrl: imageUrl,
      imageName: imageName,
    );
    FirebaseFirestore.instance.collection('notes').doc().set(note.toJson());
  }

  Future<void> pickImage() async {
    try {
      final imageFromGallery =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageFromGallery != null) {
        image = File(imageFromGallery.path);
      }
    } on PlatformException catch (e) {
      print('Faild to pick imageFromGallery - $e');
    }
  }

  Future<String> _uploadFile() async {
    String imageId = DateTime.now().millisecondsSinceEpoch.toString();
    imageName = 'image_$imageId.jps';
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageName);
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  void dispose() {}
}
