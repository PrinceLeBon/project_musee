import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/bibliotheque_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class BibliothequeRepository{
  final Database database;
  final List<Map<String, dynamic>> listbiblio=[];
  int i=0;

  BibliothequeRepository({required this.database}){
    List<BibliothequeModel> bibliotheque =
    listbiblio.map((e) => BibliothequeModel(
        id: e["id"],
        numMus: e["numMus"],
        ISBN: e["ISBN"],
        dateAchat: e["dateAchat"]
    )).toList();

    _bibliothequeController.add(bibliotheque);
  }

  StreamController<List<BibliothequeModel>> _bibliothequeController =
  StreamController<List<BibliothequeModel>>();

  Stream<List<BibliothequeModel>> get biblio => _bibliothequeController.stream;

  Future<void> initialize() async {

    List<Map<String, dynamic>> maps = await database.query('Bibliotheque');
    listbiblio.addAll(maps);

    print('au début biblio $listbiblio');

    List<BibliothequeModel> bibliotheque =
    listbiblio.map((e) => BibliothequeModel(
        id: e["id"],
        numMus: e["numMus"],
        ISBN: e["ISBN"],
        dateAchat: e["dateAchat"]
    )).toList();

    _bibliothequeController.add(bibliotheque);

  }

  Future<void> reinitialize() async {
    List<Map<String, dynamic>> maps = await database.query('Bibliotheque');
    listbiblio.clear();
    listbiblio.addAll(maps);

    List<BibliothequeModel> bibliotheque =
    listbiblio.map((e) => BibliothequeModel(
        id: e["id"],
        numMus: e["numMus"],
        ISBN: e["ISBN"],
        dateAchat: e["dateAchat"]
    )).toList();

    _bibliothequeController.add(bibliotheque);
  }

  Future<void> add(Map<String, dynamic> data) async{

    final BibliothequeModel bibliothequeModel = BibliothequeModel(
        id: listbiblio.length+1,
        numMus: data["numMus"],
        ISBN: data["ISBN"],
      dateAchat: data["dateAchat"]
    );

    int id = await database.insert(
      'Bibliotheque',
      bibliothequeModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listbiblio.add({...data, ...{"id": id}});
    print('Après insertion $listbiblio');

    List<BibliothequeModel> bibliotheque =
    listbiblio.map((e) => BibliothequeModel(
        id: e["id"],
        numMus: e["numMus"],
        ISBN: e["ISBN"],
        dateAchat: e["dateAchat"]
    )).toList();

    _bibliothequeController.add(bibliotheque);
  }

  Future<void> update(Map<String, dynamic> data, Map<String, dynamic> ancienne) async {
    final BibliothequeModel bibliothequeModel = BibliothequeModel(
        id: data["id"],
        numMus: data["numMus"],
        ISBN: data["ISBN"],
        dateAchat: data["dateAchat"]);
    database.update(
      'Bibliotheque',
      bibliothequeModel.toJson(),
      where: 'id = ?',
      whereArgs: [ancienne["id"]],
    );

    List<BibliothequeModel> bibliotheque =
    listbiblio.map((e) => BibliothequeModel(
        id: e["id"],
        numMus: e["numMus"],
        ISBN: e["ISBN"],
        dateAchat: e["dateAchat"]
    )).toList();

    int id = bibliotheque.indexWhere((element) => element.id == ancienne["id"]);
    bibliotheque.removeAt(id);
    bibliotheque.insert(id, BibliothequeModel(id: data["id"], numMus: data["numMus"], ISBN: data["ISBN"], dateAchat: data["dateAchat"]));
    listbiblio.removeAt(id);
    listbiblio.insert(id, {
      "id": data["id"],
      "numMus": data["numMus"],
      "ISBN": data["ISBN"],
      "dateAchat": data["dateAchat"]
    });
    _bibliothequeController.add(bibliotheque);
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();

  }

  Future<void> remove(BibliothequeModel bibliothequeModel) async{

    await database.delete(
      'Bibliotheque',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [bibliothequeModel.id],
    );
    listbiblio.removeWhere((element) => element["id"] == bibliothequeModel.id);

    List<BibliothequeModel> bibliotheque =
    listbiblio.map((e) => BibliothequeModel(
        id: e["id"],
        numMus: e["numMus"],
        ISBN: e["ISBN"],
        dateAchat: e["dateAchat"]
    )).toList();

    _bibliothequeController.add(bibliotheque);
    ouvrageRepository.reinitialize();
    bibliothequeRepository.reinitialize();
    paysRepository.reinitialize();
    museeRepository.reinitialize();
    visiterRepository.reinitialize();
    momentRepository.reinitialize();
    print('Après suppresion $listbiblio');
  }


}