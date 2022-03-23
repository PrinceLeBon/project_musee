import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/repositories/musee_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class PaysRepository{
  final Database database;
  final List<Map<String, dynamic>> listpays=[];
  int i=0;

  PaysRepository({required this.database}){
    List<PaysModel> pays =
    listpays.map((e) => PaysModel(codePays: e["codePays"], nbhabitant: e["nbhabitant"])).toList();

    _payscontroller.add(pays);
  }

  StreamController<List<PaysModel>> _payscontroller =
  StreamController<List<PaysModel>>();

  Stream<List<PaysModel>> get pays => _payscontroller.stream;

  Future<void> initialize() async {

    List<Map<String, dynamic>> maps = await database.query('Pays');
    listpays.addAll(maps);

    print('au début pays $listpays');

    List<PaysModel> pays =
    listpays.map((e) => PaysModel(codePays: e["codePays"], nbhabitant: e["nbhabitant"])).toList();

    _payscontroller.add(pays);

  }

  Future<void> reinitialize() async {

    List<Map<String, dynamic>> maps = await database.query('Pays');
    listpays.clear();
    listpays.addAll(maps);

    print('au début pays $listpays');

    List<PaysModel> pays =
    listpays.map((e) => PaysModel(codePays: e["codePays"], nbhabitant: e["nbhabitant"])).toList();

    _payscontroller.add(pays);

  }

  Future<void> add(Map<String, dynamic> data) async{

    final PaysModel paysModel = PaysModel(
        codePays: data["codePays"],
        nbhabitant: data["nbhabitant"]
    );

    int id = await database.insert(
      'Pays',
      paysModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listpays.add(data);
    print('Après insertion $listpays');

    List<PaysModel> pays =
    listpays.map((e) => PaysModel(codePays: e["codePays"], nbhabitant: e["nbhabitant"])).toList();

    _payscontroller.add(pays);
  }

  Future<void> update(Map<String, dynamic> data, Map<String, dynamic> ancienne) async {
    final PaysModel paysModel = PaysModel(
        codePays: data["codePays"],
        nbhabitant: data["nbhabitant"]);
    database.update(
      'Pays',
      paysModel.toJson(),
      where: 'codePays = ?',
      whereArgs: [ancienne["codePays"]],
    );

    List<PaysModel> pays =
    listpays.map((e) => PaysModel(codePays: e["codePays"], nbhabitant: e["nbhabitant"])).toList();
    int id = pays.indexWhere((element) => element.codePays == ancienne["codePays"]);
    pays.removeAt(id);
    pays.insert(id, PaysModel(codePays: data["codePays"], nbhabitant: data["nbhabitant"]));

    listpays.removeAt(id);
    listpays.insert(id, {
      "codePays": data["codePays"],
      "nbhabitant": data["nbhabitant"]
    });
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();
    _payscontroller.add(pays);
  }

  Future<void> remove(PaysModel paysModel) async{

    await database.delete(
      'Pays',
      // Use a `where` clause to delete a specific dog.
      where: 'codePays = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [paysModel.codePays],
    );
    listpays.removeWhere((element) => element["codePays"] == paysModel.codePays);

    List<PaysModel> pays =
    listpays.map((e) => PaysModel(codePays: e["codePays"], nbhabitant: e["nbhabitant"])).toList();
    _payscontroller.add(pays);
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();
    print('Après suppresion $listpays');
  }


}