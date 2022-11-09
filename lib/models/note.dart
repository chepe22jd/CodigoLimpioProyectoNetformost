// To parse this JSON data, do
class Notes {
  int? id;
  String nameNote;
  String date;
  String note;

  Notes(
      {this.id,
      required this.nameNote,
      required this.date,
      required this.note});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nameNote': nameNote, 'date': date, 'note': note};
  }
}
