class VisiterModel{
  final int id;
  final int numMus;
  final String jour;
  final int nbvisiteurs;

  const VisiterModel({required this.id, required this.numMus, required this.jour, required this.nbvisiteurs});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numMus': numMus,
      'jour': jour,
      'nbvisiteurs': nbvisiteurs,
    };
  }
}