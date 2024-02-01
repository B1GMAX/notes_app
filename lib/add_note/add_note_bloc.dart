import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note_model.dart';

class AddNoteBloc {
  final noteTextEditingController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;

  File? image;

  void createNote() async {
    final imageUrl = await _uploadFile();
    final NoteModel note = NoteModel(
      name: noteTextEditingController.text.trim(),
      date: convertDate(),
      imageUrl: imageUrl,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .doc()
        .set(note.toJson());
  }

  String convertDate() {
    return DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  Future<void> pickImage() async {
    try {
      final imageFromGallery =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageFromGallery != null) {
        image = File(imageFromGallery.path);
      }
    } on PlatformException catch (e) {
      print('Failed to pick imageFromGallery - $e');
    }
  }

  Future<String> _uploadFile() async {
    if (image != null) {
      String imageId = DateTime.now().toString();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child('image_$imageId.jps');
      await ref.putFile(image!);
      return await ref.getDownloadURL();
    } else {
      return '';
    }
  }

  void dispose() {
    noteTextEditingController.dispose();
  }
}
