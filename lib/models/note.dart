// To parse this JSON data, do
class Notas {
  int? id;
  String nombreNota;
  String fecha;
  String nota;

  Notas(
      {this.id,
      required this.nombreNota,
      required this.fecha,
      required this.nota});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombreNota': nombreNota, 'fecha': fecha, 'nota': nota};
  }
}
