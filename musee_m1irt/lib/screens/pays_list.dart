import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/components/pays/pays_edit.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/services/pays/list_pays/list_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/remove_pays/remove_pays_bloc.dart';

class pays_list extends StatelessWidget {
  const pays_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemovePaysBloc,RemovePaysState>(
      listener: (context, state) {
        if (state is RemovePaysSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text('Suppression réussie'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: BlocConsumer<ListPaysBloc, ListPaysState>(
          listener: (context, state) {},
          builder: (context, state){
            List<PaysModel> listpays = [];
            if (state is ListState) {
              listpays = state.listpays;
              global_list_pays = listpays;
            }
            return listpays.isEmpty
                ? const Center(child: Text('Pas d\'éléments'))
                : ListView.builder(
                itemCount: listpays.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                  child: Card(
                    child: ListTile(
                      title: Text("${listpays[index].codePays}"),
                      subtitle: Text("${listpays[index].nbhabitant} habitants"),
                      leading: Pays_edit(listpays[index].codePays, listpays[index].nbhabitant!),
                      trailing: IconButton(
                          onPressed: (){
                            context.read<RemovePaysBloc>().add(
                                OnRemovePaysEvent(paysModel: listpays[index])
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
                    context.read<RemovePaysBloc>().add(
                        OnRemovePaysEvent(paysModel: listpays[index])
                    );
                  },
                )
            );
          }
      ),
    );
  }
}
