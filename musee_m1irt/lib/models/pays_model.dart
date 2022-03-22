class PaysModel{
  final String codePays;
  final int? nbhabitant;
  const PaysModel({required this.codePays, required this.nbhabitant});

  Map<String, dynamic> toJson() {
    return {
      'codePays': codePays,
      'nbhabitant': nbhabitant,
    };
  }
}