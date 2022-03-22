import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/moment_model.dart';
import 'package:musee_m1irt/services/moment/list_moment/list_moment_bloc.dart';
import 'package:musee_m1irt/services/moment/remove_moment/remove_moment_bloc.dart';

import '../components/moment/moment_edit.dart';

class moment_list extends StatelessWidget {
  const moment_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveMomentBloc,RemoveMomentState>(
      listener: (context, state) {
        if (state is RemoveMomentSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text('Suppression réussie'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: BlocConsumer<ListMomentBloc, ListMomentState>(
          listener: (context, state) {},
          builder: (context, state){
            List<MomentModel> listMoment = [];
            if (state is ListState) {
              listMoment = state.listmoment;
              global_list_moment = listMoment;
            }
            return listMoment.isEmpty
                ? const Center(child: Text('Pas d\'éléments'))
                : ListView.builder(
                itemCount: listMoment.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                  child: Card(
                    child: ListTile(
                      title: Text(listMoment[index].jour),
                      leading: Moment_edit(listMoment[index].jour),
                      trailing: IconButton(
                          onPressed: (){
                            context.read<RemoveMomentBloc>().add(
                                OnRemoveMomentEvent(momentModel: listMoment[index])
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  background: Container(
                    color: Colors.green,
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart){
                      context.read<RemoveMomentBloc>().add(
                          OnRemoveMomentEvent(momentModel: listMoment[index])
                      );
                    }else if (direction == DismissDirection.startToEnd){

                    }
                  },
                )
            );
          }
      ),
    );
  }
}
