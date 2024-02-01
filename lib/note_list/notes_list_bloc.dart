import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final List<NoteModel> notes = [];

  final BehaviorSubject<List<NoteModel>> _noteModelListController =
      BehaviorSubject();

  Stream<List<NoteModel>> get noteModelListStream =>
      _noteModelListController.stream;

  Stream<List<NoteModel>> getAllNotes() => FirebaseFirestore.instance
      .collection('notes')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => NoteModel.fromJson(doc.data())).toList());

  void dispose() {}
}
