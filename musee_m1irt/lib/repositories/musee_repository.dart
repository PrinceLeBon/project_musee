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

  Future<List<MuseeModel>> recuperation() async{
    List<Map<String, dynamic>> maps = await database.query('Musee');
    listmusee.addAll(maps);

    print('recuperation $listmusee');

    return listmusee.map((e) => MuseeModel(
        numMus: e["numMus"],
        nomMus: e["nomMus"],
        nblivres: e["nblivres"],
        codePays: e["codePays"])).toList();
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
        numMus: ancienne["numMus"],
        nomMus: ancienne["nomMus"],
        nblivres: ancienne["nblivres"],
        codePays: ancienne["codePays"]);

    await remove(museeModel);
    await add(data);

    print('Après modification $listmusee');
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
    print('Après suppresion $listmusee');
  }


}