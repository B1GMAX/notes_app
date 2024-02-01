class NoteModel {
  String name;
  String imageUrl;
  String? id;
  String date;

  NoteModel({
    required this.name,
    required this.date,
    required this.imageUrl,
    this.id,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json, String id) => NoteModel(
        name: json['name'],
        date: json['date'],
        imageUrl: json['image'],
        id: id,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': imageUrl,
        'date': date,
        'id': id,
      };
}
