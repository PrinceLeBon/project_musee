class MuseeModel{
  final int? numMus;
  final String nomMus;
  final int? nblivres;
  final String codePays;

  const MuseeModel({required this.numMus, required this.nomMus,required this.nblivres,required this.codePays});

  Map<String, dynamic> toJson() {
    return {
      'numMus': numMus,
      'nomMus': nomMus,
      'nblivres': nblivres,
      'codePays': codePays,
    };
  }
}