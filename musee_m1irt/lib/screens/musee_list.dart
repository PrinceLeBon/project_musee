import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/components/musee/musee_edit.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/services/musee/list_musee/list_musee_bloc.dart';
import 'package:musee_m1irt/services/musee/remove_musee/remove_musee_bloc.dart';

class musee_list extends StatelessWidget {
  const musee_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveMuseeBloc,RemoveMuseeState>(
      listener: (context, state) {
        if (state is RemoveMuseeSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text('Suppression réussie'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: BlocConsumer<ListMuseeBloc, ListMuseeState>(
          listener: (context, state) {},
          builder: (context, state){
            List<MuseeModel> listmusee = [];
            if (state is ListState) {
              listmusee = state.listmusee;
              global_list_musee =listmusee;
            }
            return listmusee.isEmpty
                ? const Center(child: Text('Pas d\'éléments'))
                : ListView.builder(
                itemCount: listmusee.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                  child: Card(
                    child: ListTile(
                      title: Text(listmusee[index].nomMus),
                      subtitle: Text("${listmusee[index].nblivres} livres, Code Pays:${listmusee[index].codePays}"),
                      leading: Musee_edit(listmusee[index].numMus!, listmusee[index].nomMus, listmusee[index].nblivres!, listmusee[index].codePays),
                      trailing: IconButton(
                          onPressed: (){
                            context.read<RemoveMuseeBloc>().add(
                                OnRemoveMuseeEvent(museeModel: listmusee[index])
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
                    context.read<RemoveMuseeBloc>().add(
                        OnRemoveMuseeEvent(museeModel: listmusee[index])
                    );
                  },
                )
            );
          }
      ),
    );
  }
}
