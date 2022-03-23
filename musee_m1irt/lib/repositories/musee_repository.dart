import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MuseeRepository{
  final Database database;
  final List<Map<String, dynamic>> listmusee=[];
  int i=0;

  MuseeRepository({required this.database}){
    List<MuseeModel> musee =
    listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();

    _museecontroller.add(musee);
  }

  StreamController<List<MuseeModel>> _museecontroller =
  StreamController<List<MuseeModel>>();

  Stream<List<MuseeModel>> get musee => _museecontroller.stream;

  Future<void> initialize() async {

    List<Map<String, dynamic>> maps = await database.query('Musee');
    listmusee.addAll(maps);

    print('au début musee $listmusee');

    List<MuseeModel> musee =
    listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();

    _museecontroller.add(musee);

  }

  Future<void> reinitialize() async {

    List<Map<String, dynamic>> maps = await database.query('Musee');
    listmusee.clear();
    listmusee.addAll(maps);

    print('reinitialisation musee $listmusee');

    List<MuseeModel> musee =
    listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();

    _museecontroller.add(musee);

  }

  Future<void> add(Map<String, dynamic> data) async{

    final MuseeModel museeModel = MuseeModel(
        numMus: listmusee.length+1,
        nomMus: data["nomMus"],
        nblivres: data["nblivres"],
        codePays: data["codePays"]);

    int id = await database.insert(
      'Musee',
      museeModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listmusee.add({...data, ...{"numMus": id}});
    print('Après insertion $listmusee');

    List<MuseeModel> musee =
    listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();

    _museecontroller.add(musee);
  }

  Future<void> update(Map<String, dynamic> data, Map<String, dynamic> ancienne) async {
    final MuseeModel museeModel = MuseeModel(
        numMus: data["numMus"],
        nomMus: data["nomMus"],
        nblivres: data["nblivres"],
        codePays: data["codePays"]);
    database.update(
      'Musee',
      museeModel.toJson(),
      where: 'numMus = ?',
      whereArgs: [ancienne["numMus"]],
    );

    List<MuseeModel> musee =
    listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();
    int id = musee.indexWhere((element) => element.numMus == ancienne["numMus"]);
    musee.removeAt(id);
    musee.insert(id, MuseeModel(numMus: data["numMus"], nomMus: data["nomMus"], nblivres: data["nblivres"], codePays: data["codePays"]));
    listmusee.removeAt(id);
    listmusee.insert(id, {
      "numMus": data["numMus"],
      "nomMus": data["nomMus"],
      "nblivres": data["nblivres"],
      "codePays": data["codePays"]
    });
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();

    _museecontroller.add(musee);
  }

  Future<void> remove(MuseeModel museeModel) async{

    await database.delete(
      'Musee',
      // Use a `where` clause to delete a specific dog.
      where: 'numMus = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [museeModel.numMus],
    );
    listmusee.removeWhere((element) => element["numMus"] == museeModel.numMus);

    List<MuseeModel> musee =
    listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();
    _museecontroller.add(musee);
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();
    print('Après suppresion $listmusee');
  }


}