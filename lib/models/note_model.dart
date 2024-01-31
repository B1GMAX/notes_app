class NoteModel {
  String name;
  String image;
  String date;

  NoteModel({
    required this.name,
    required this.date,
    required this.image,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      NoteModel(name: json['name'], date: json['date'], image: json['image']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'date': date,
      };
}
