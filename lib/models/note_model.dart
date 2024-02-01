class NoteModel {
  String name;
  String imageUrl;
  String imageName;
  String date;

  NoteModel({
    required this.name,
    required this.date,
    required this.imageUrl,
    required this.imageName,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
      name: json['name'],
      date: json['date'],
      imageUrl: json['image'],
      imageName: json['imageName']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': imageUrl,
        'date': date,
        'imageName': imageName,
      };
}
