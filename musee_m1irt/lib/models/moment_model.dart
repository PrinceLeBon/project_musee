class MomentModel{
  final String jour;

  const MomentModel({required this.jour});

  Map<String, dynamic> toJson() {
    return {
      'jour': jour,
    };
  }
}