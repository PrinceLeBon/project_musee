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
    final BibliothequeModel ancienbibliothequeModel = BibliothequeModel(
        id: ancienne["id"],
        numMus: ancienne["numMus"],
        ISBN: ancienne["ISBN"],
        dateAchat: ancienne["dateAchat"]);

    await remove(ancienbibliothequeModel);
    await add(data);

    print('Après modification $listbiblio');
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
    print('Après suppresion $listbiblio');
  }


}