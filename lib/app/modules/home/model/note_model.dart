
class Note {

  String title;
  final DateTime dateTime;
  String contenu;
  String path;
  final int? id;

  Note(
      {required this.title,
      required this.dateTime,
      required this.contenu,
      required this.path,
      this.id});

  factory Note.fromJson(Map<String, dynamic> json) {
    var history = new Note(
        id: json['_id'],
        title: json['title'],
        dateTime:
            new DateTime.fromMicrosecondsSinceEpoch(int.parse(json['date'])),
        contenu: json['contenu'],
        path: json['path']);
    return history;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.dateTime.microsecondsSinceEpoch.toString();
    data['contenu'] = this.contenu;
    data['path'] = this.path;
    return data;
  }

}
