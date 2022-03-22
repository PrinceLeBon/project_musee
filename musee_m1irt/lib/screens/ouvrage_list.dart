import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/components/ouvrage/ouvrage_edit.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/ouvrage_model.dart';
import 'package:musee_m1irt/services/ouvrage/list_ouvrage/list_ouvrage_bloc.dart';
import 'package:musee_m1irt/services/ouvrage/remove_ouvrage/remove_ouvrage_bloc.dart';

class ouvrage_list extends StatelessWidget {
  const ouvrage_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveOuvrageBloc, RemoveOuvrageState>(
      listener: (context, state) {
        if (state is RemoveOuvrageSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text('Suppression réussie'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: BlocConsumer<ListOuvrageBloc, ListOuvrageState>(
          listener: (context, state) {},
          builder: (context, state){
            List<OuvrageModel> listouvrage = [];
            if (state is ListState) {
              listouvrage = state.listouvrage;
              global_list_ouvrage =listouvrage;
            }
            return listouvrage.isEmpty
                ? const Center(child: Text('Pas d\'éléments'))
                : ListView.builder(
                itemCount: listouvrage.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                  child: Card(
                    child: ListTile(
                      title: Text(listouvrage[index].titre),
                      subtitle: Text("${listouvrage[index].nbPage} page, ISBN:${listouvrage[index].ISBN}, Code Pays ${listouvrage[index].codePays}"),
                      leading: Ouvrage_edit(listouvrage[index].ISBN, listouvrage[index].titre, listouvrage[index].nbPage, listouvrage[index].codePays),
                      trailing: IconButton(
                          onPressed: (){
                            context.read<RemoveOuvrageBloc>().add(
                                OnRemoveOuvrageEvent(ouvrageModel: listouvrage[index])
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
                    context.read<RemoveOuvrageBloc>().add(
                        OnRemoveOuvrageEvent(ouvrageModel: listouvrage[index])
                    );
                  },
                )
            );
          }
      ),
    );
  }
}
