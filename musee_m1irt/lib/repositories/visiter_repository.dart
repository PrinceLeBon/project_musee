import 'package:musee_m1irt/models/visiter_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class VisiterRepository{
  final Database database;
  final List<Map<String, dynamic>> listvisiter=[];
  int i=0;

  VisiterRepository({required this.database}){
    List<VisiterModel> visiter =
    listvisiter.map((e) => VisiterModel(
        id: e["id"],
        numMus: e["numMus"],
        jour: e["jour"],
        nbvisiteurs: e["nbvisiteurs"]
    )).toList();

    _visitercontroller.add(visiter);
  }

  StreamController<List<VisiterModel>> _visitercontroller =
  StreamController<List<VisiterModel>>();

  Stream<List<VisiterModel>> get visiter => _visitercontroller.stream;

  Future<void> initialize() async {

    List<Map<String, dynamic>> maps = await database.query('Visiter');
    listvisiter.addAll(maps);

    print('au début visiter $listvisiter');

    List<VisiterModel> visiter =
    listvisiter.map((e) => VisiterModel(
        id: e["id"],
        numMus: e["numMus"],
        jour: e["jour"],
        nbvisiteurs: e["nbvisiteurs"]
    )).toList();

    _visitercontroller.add(visiter);

  }

  Future<void> add(Map<String, dynamic> data) async{

    final VisiterModel visiterModel = VisiterModel(
        id: listvisiter.length+1,
        numMus: data["numMus"],
        jour: data["jour"],
        nbvisiteurs: data["nbvisiteurs"]
    );

    int id = await database.insert(
      'Visiter',
      visiterModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listvisiter.add({...data, ...{"id": id}});
    print('Après insertion $listvisiter');

    List<VisiterModel> visiter =
    listvisiter.map((e) => VisiterModel(
        id: e["id"],
        numMus: e["numMus"],
        jour: e["jour"],
        nbvisiteurs: e["nbvisiteurs"]
    )).toList();

    _visitercontroller.add(visiter);
  }

  Future<void> update(Map<String, dynamic> data, Map<String, dynamic> ancienne) async {
    final VisiterModel visiterModel = VisiterModel(
        id: ancienne["id"],
        numMus: ancienne["numMus"],
        jour: ancienne["jour"],
        nbvisiteurs: ancienne["nbvisiteurs"]);

    await remove(visiterModel);
    await add(data);

    print('Après modification $listvisiter');
  }

  Future<void> remove(VisiterModel visiterModel) async{

    await database.delete(
      'Visiter',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [visiterModel.id],
    );
    listvisiter.removeWhere((element) => element["id"] == visiterModel.id);

    List<VisiterModel> visiter =
    listvisiter.map((e) => VisiterModel(
        id: e["id"],
        numMus: e["numMus"],
        jour: e["jour"],
        nbvisiteurs: e["nbvisiteurs"]
    )).toList();

    _visitercontroller.add(visiter);
    print('Après suppresion $listvisiter');
  }


}