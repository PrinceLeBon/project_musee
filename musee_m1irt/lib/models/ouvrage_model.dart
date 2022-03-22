class OuvrageModel{
  final int ISBN;
  final int nbPage;
  final String titre;
  final String codePays;
  const OuvrageModel({required this.ISBN, required this.nbPage, required this.titre,required this.codePays});

  Map<String, dynamic> toJson() {
    return {
      'ISBN': ISBN,
      'nbPage': nbPage,
      'titre': titre,
      'codePays': codePays,
    };
  }
}