import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

class NotesBloc {
  final List<NoteModel> notes = [];

  final BehaviorSubject<List<NoteModel>> _noteModelListController =
      BehaviorSubject();

  Stream<List<NoteModel>> get noteModelListStream =>
      _noteModelListController.stream;

  final collection = FirebaseFirestore.instance.collection('notes');

  Stream<List<NoteModel>> getAllNotes() =>
      collection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return NoteModel.fromJson(doc.data(), doc.id);
        }).toList();
      });

  String convertDate(String date) {
    final tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    return DateFormat("yyyy-MM-dd").format(tempDate);
  }

  void removeNote(String id) {
    collection.doc(id).delete();
  }

  void dispose() {}
}
