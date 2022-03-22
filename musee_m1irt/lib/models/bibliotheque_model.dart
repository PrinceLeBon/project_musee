class BibliothequeModel{
  final int id;
  final int numMus;
  final int ISBN;
  final String dateAchat;

  const BibliothequeModel({required this.id, required this.numMus,required this.ISBN,required this.dateAchat});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numMus': numMus,
      'ISBN': ISBN,
      'dateAchat': dateAchat,
    };
  }
}