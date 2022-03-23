import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/moment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MomentRepository{
  final Database database;
  final List<Map<String, dynamic>> listmoment=[];
  int i=0;

  MomentRepository({required this.database}){
    List<MomentModel> moment =
    listmoment.map((e) => MomentModel(jour: e["jour"])).toList();

    _momentontroller.add(moment);
  }

  StreamController<List<MomentModel>> _momentontroller =
  StreamController<List<MomentModel>>();

  Stream<List<MomentModel>> get moment => _momentontroller.stream;

  Future<void> initialize() async {

    List<Map<String, dynamic>> maps = await database.query('Moment');
    listmoment.addAll(maps);

    print('au début moment $listmoment');

    List<MomentModel> moment =
    listmoment.map((e) => MomentModel(jour: e["jour"])).toList();

    _momentontroller.add(moment);

  }

  Future<void> reinitialize() async {

    List<Map<String, dynamic>> maps = await database.query('Moment');
    listmoment.clear();
    listmoment.addAll(maps);

    print('au début moment $listmoment');

    List<MomentModel> moment =
    listmoment.map((e) => MomentModel(jour: e["jour"])).toList();

    _momentontroller.add(moment);

  }

  Future<void> add(Map<String, dynamic> data) async{

    final MomentModel momentModel = MomentModel(
        jour: data["jour"]
    );

    int id = await database.insert(
      'Moment',
      momentModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listmoment.add(data);
    print('Après insertion $listmoment');

    List<MomentModel> moment =
    listmoment.map((e) => MomentModel(jour: e["jour"])).toList();
    int k = moment.indexOf(MomentModel(jour: "lundi"));
    print("voici lid $k");
    _momentontroller.add(moment);
  }

  Future<void> update(Map<String, dynamic> data, String ancienne_valeur) async {
    final MomentModel momentModel = MomentModel(
    jour: data["jour"]
    );
    // Update the given Dog.
    database.update(
      'Moment',
      momentModel.toJson(),
      where: 'jour = ?',
      whereArgs: [ancienne_valeur],
    );
    List<MomentModel> moment =
    listmoment.map((e) => MomentModel(jour: e["jour"])).toList();
    int id = moment.indexWhere((element) => element.jour == ancienne_valeur);
    moment.removeAt(id);
    moment.insert(id, MomentModel(jour: data["jour"]));
    listmoment.removeAt(id);
    listmoment.insert(id, {
      "jour": data["jour"]
    });
    _momentontroller.add(moment);
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();
  }

  Future<void> remove(MomentModel momentModel) async{

    await database.delete(
      'Moment',
      where: 'jour = ?',
      whereArgs: [momentModel.jour],
    );
    listmoment.removeWhere((element) => element["jour"] == momentModel.jour);

    List<MomentModel> moment =
    listmoment.map((e) => MomentModel(jour: e["jour"])).toList();
    _momentontroller.add(moment);
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();
    print('Après suppresion $listmoment');
  }


}