import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/components/visiter/visiter_edit.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/models/visiter_model.dart';
import 'package:musee_m1irt/services/visiter/list_visiter/list_visiter_bloc.dart';
import 'package:musee_m1irt/services/visiter/remove_visiter/remove_visiter_bloc.dart';

class visiter_list extends StatelessWidget {
  const visiter_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveVisiterBloc,RemoveVisiterState>(
      listener: (context, state) {
        if (state is RemoveVisiterSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text('Suppression réussie'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: BlocConsumer<ListVisiterBloc, ListVisiterState>(
          listener: (context, state) {},
          builder: (context, state){
            List<VisiterModel> listvisiter = [];
            if (state is ListState) {
              listvisiter = state.listvisiter;
              global_list_visiter =listvisiter;
            }
            return listvisiter.isEmpty
                ? const Center(child: Text('Pas d\'éléments'))
                : ListView.builder(
                itemCount: listvisiter.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                  child: Card(
                    child: ListTile(
                      title: Text(listvisiter[index].jour),
                      subtitle: Text("Musée: ${listvisiter[index].numMus}-,${recheche_musee(global_list_musee, listvisiter[index].numMus)}, ${listvisiter[index].nbvisiteurs} visiteurs"),
                      leading: Visiter_edit(listvisiter[index].id, listvisiter[index].numMus, listvisiter[index].jour, listvisiter[index].nbvisiteurs),
                      trailing: IconButton(
                          onPressed: (){
                            context.read<RemoveVisiterBloc>().add(
                                OnRemoveVisiterEvent(visiterModel: listvisiter[index])
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
                    context.read<RemoveVisiterBloc>().add(
                        OnRemoveVisiterEvent(visiterModel: listvisiter[index])
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
