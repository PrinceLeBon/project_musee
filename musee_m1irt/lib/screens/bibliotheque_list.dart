import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/components/bibliotheque/bibliotheque_edit.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/bibliotheque_model.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/services/bibliotheque/list_bibliotheque/list_bibliotheque_bloc.dart';
import 'package:musee_m1irt/services/bibliotheque/remove_bibliotheque/remove_bibliotheque_bloc.dart';

class bibliotheque_list extends StatelessWidget {
  const bibliotheque_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveBibliothequeBloc,RemoveBibliothequeState>(
      listener: (context, state) {
        if (state is RemoveBibliothequeSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text('Suppression réussie'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: BlocConsumer<ListBibliothequeBloc, ListBibliothequeState>(
          listener: (context, state) {},
          builder: (context, state){
            List<BibliothequeModel> listbiblio = [];
            if (state is ListState) {
              listbiblio = state.listbiblio;
              global_list_bibliotheque=listbiblio;
            }
            return listbiblio.isEmpty
                ? const Center(child: Text('Pas d\'éléments'))
                : ListView.builder(
                itemCount: listbiblio.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                  child: Card(
                    child: ListTile(
                      title: Text("Num Mus: ${listbiblio[index].numMus} -,${recheche_musee(global_list_musee, listbiblio[index].numMus)}"),
                      subtitle: Text("ISBN: ${listbiblio[index].ISBN}, Date Achat: ${listbiblio[index].dateAchat}"),
                      leading: Bibliotheque_edit(listbiblio[index].id, listbiblio[index].numMus, listbiblio[index].ISBN, listbiblio[index].dateAchat),
                        trailing: IconButton(
                          onPressed: (){
                            context.read<RemoveBibliothequeBloc>().add(
                                OnRemoveBibliothequeEvent(bibliothequeModel: listbiblio[index])
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    context.read<RemoveBibliothequeBloc>().add(
                        OnRemoveBibliothequeEvent(bibliothequeModel: listbiblio[index])
                    );
                  },
                )
            );
          }
      ),
    );
  }

  String? recheche_musee(List<MuseeModel> list, int num){
    for (int i=0; i< list.length; i++){
      if (list[i].numMus == num){
        return list[i].nomMus;
      }
    }
  }
}
