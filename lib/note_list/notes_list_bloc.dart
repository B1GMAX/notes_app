import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _userCollection = FirebaseFirestore.instance.collection('users');

  final _collectionController = BehaviorSubject<List<NoteModel>>();

  Stream<List<NoteModel>> get notes => _collectionController.stream;

  StreamSubscription? collectionListener;

  NotesBloc() {
    collectionListener = _userCollection
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .snapshots()
        .listen((querySnapshot) {
      _collectionController.add(querySnapshot.docs
          .map(
            (doc) => NoteModel.fromJson(doc.data(), doc.id),
          )
          .toList());
    });
  }

  void removeNote(String id) {
    _userCollection
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  void dispose() {
    collectionListener?.cancel();
    _collectionController.close();
  }
}
