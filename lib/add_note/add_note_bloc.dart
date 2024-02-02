import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNoteBloc {
  final noteTextEditingController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _isNoteSavedController = BehaviorSubject<bool>();

  final _fileImageController = BehaviorSubject<File>();

  Stream<bool> get isNoteSavedStream => _isNoteSavedController.stream;

  Stream<File> get fileImageStream => _fileImageController.stream;

  File? _image;

  Future<bool> createNote() async {
    if (noteTextEditingController.text.isNotEmpty) {
      _isNoteSavedController.add(true);
      final imageUrl = await _uploadFile();
      final NoteModel note = NoteModel(
        name: noteTextEditingController.text.trim(),
        date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
        imageUrl: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc()
          .set(note.toJson());

      _isNoteSavedController.add(false);
      return true;
    }
    return false;
  }

  Future<void> pickImage() async {
    try {
      final imageFromGallery =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFromGallery != null) {
        _image = File(imageFromGallery.path);
        if (_image != null) {
          _fileImageController.add(_image!);
        }
      }
    } on PlatformException {
      Fluttertoast.showToast(
        msg: "Failed to pick image from gallery",
      );
    }
  }

  Future<String?> _uploadFile() async {
    if (_image != null) {
      final Reference ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child('image_${DateTime.now().toString()}.jpg');
      final uploadResult = await ref.putFile(_image!);
      if (uploadResult.state == TaskState.success) {
        return await ref.getDownloadURL();
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong when load image",
        );
      }
    }
    return null;
  }

  void dispose() {
    noteTextEditingController.dispose();
    _isNoteSavedController.close();
  }
}
