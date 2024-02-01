import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final List<NoteModel> notes = [];

  final BehaviorSubject<List<NoteModel>> _noteModelListController =
      BehaviorSubject();

  Stream<List<NoteModel>> get noteModelListStream =>
      _noteModelListController.stream;

  final FirebaseAuth auth = FirebaseAuth.instance;

  final userCollection = FirebaseFirestore.instance.collection('users');

  Stream<List<NoteModel>> getAllNotes() => userCollection
          .doc(auth.currentUser!.uid)
          .collection('notes')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return NoteModel.fromJson(doc.data(), doc.id);
        }).toList();
      });



  void removeNote(String id) {
    userCollection
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  void dispose() {
    _noteModelListController.close();
  }
}
