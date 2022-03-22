import 'package:musee_m1irt/models/ouvrage_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class OuvrageRepository{
  final Database database;
  final List<Map<String, dynamic>> listouvrage=[];
  int i=0;

  OuvrageRepository({required this.database}){
    List<OuvrageModel> ouvrage =
    listouvrage.map((e) => OuvrageModel(
        ISBN: e["ISBN"],
        nbPage: e["nbPage"],
        titre: e["titre"],
        codePays: e["codePays"]
    )).toList();

    _ouvragecontroller.add(ouvrage);
  }

  StreamController<List<OuvrageModel>> _ouvragecontroller =
  StreamController<List<OuvrageModel>>();

  Stream<List<OuvrageModel>> get ouvrage => _ouvragecontroller.stream;

  Future<void> initialize() async {

    List<Map<String, dynamic>> maps = await database.query('Ouvrage');
    listouvrage.addAll(maps);

    print('au début ouvrage $listouvrage');

    List<OuvrageModel> ouvrage =
    listouvrage.map((e) => OuvrageModel(
        ISBN: e["ISBN"],
        nbPage: e["nbPage"],
        titre: e["titre"],
        codePays: e["codePays"]
    )).toList();

    _ouvragecontroller.add(ouvrage);

  }

  Future<void> add(Map<String, dynamic> data) async{

    final OuvrageModel ouvrageModel = OuvrageModel(
        ISBN: data["ISBN"],
        nbPage: data["nbPage"],
        titre: data["titre"],
        codePays: data["codePays"]
    );

    int id = await database.insert(
      'Ouvrage',
      ouvrageModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listouvrage.add(data);
    print('Après insertion $listouvrage');

    List<OuvrageModel> ouvrage =
    listouvrage.map((e) => OuvrageModel(
        ISBN: e["ISBN"],
        nbPage: e["nbPage"],
        titre: e["titre"],
        codePays: e["codePays"]
    )).toList();

    _ouvragecontroller.add(ouvrage);
  }

  Future<void> update(Map<String, dynamic> data, Map<String, dynamic> ancienne) async {
    final OuvrageModel ouvrageModel = OuvrageModel(
        ISBN: ancienne["ISBN"],
        nbPage: ancienne["nbPage"],
        titre: ancienne["titre"],
        codePays: ancienne["codePays"]);

    await remove(ouvrageModel);
    await add(data);

    print('Après modification $listouvrage');
  }

  Future<void> remove(OuvrageModel ouvrageModel) async{

    await database.delete(
      'Ouvrage',
      // Use a `where` clause to delete a specific dog.
      where: 'ISBN = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [ouvrageModel.ISBN],
    );
    listouvrage.removeWhere((element) => element["ISBN"] == ouvrageModel.ISBN);

    List<OuvrageModel> ouvrage =
    listouvrage.map((e) => OuvrageModel(
        ISBN: e["ISBN"],
        nbPage: e["nbPage"],
        titre: e["titre"],
        codePays: e["codePays"]
    )).toList();

    _ouvragecontroller.add(ouvrage);
    print('Après suppresion $listouvrage');
  }


}