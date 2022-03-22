import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/services/moment/edit_moment/edit_moment_bloc.dart';

class Moment_edit extends StatefulWidget {
  final String libelle;
  const Moment_edit(this.libelle, {Key? key}) : super(key: key);

  @override
  _Moment_editState createState() => _Moment_editState();
}

class _Moment_editState extends State<Moment_edit> {
  TextEditingController _controller = TextEditingController();
  late String ancienne_valeur;
  bool trouve = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller.text = widget.libelle;
    ancienne_valeur = widget.libelle;
    super.initState();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      //blocklistener pour écouter une action
      builder: (context) => BlocListener<EditMomentBloc, EditMomentState>(
        listener: (content, state){
          if (state is EditMomentSuccessState){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Modification effectué'),
                  duration: Duration(seconds: 1),
                )
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Modification de Moment".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration:
                  const InputDecoration(hintText: 'Modifier le jour'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _controller.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Anuuler".toUpperCase())),
                  TextButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          if (global_list_moment.isNotEmpty) {
                            for (int i = 0; i < global_list_moment.length; i++) {
                              if ((global_list_moment[i].jour == _controller.text)){
                                (trouve = true);
                                break;
                              }else {
                                (trouve = false);
                              }
                            }
                            if (trouve) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Ce jour existe déjà')));
                            } else {
                              print(_controller.text);
                              context.read<EditMomentBloc>().add(
                                  OnEditMomentEvent(jour: _controller.text, ancienne: ancienne_valeur));
                              _controller.clear();
                            }
                          } else {
                            context.read<EditMomentBloc>().add(
                                OnEditMomentEvent(jour: _controller.text, ancienne: ancienne_valeur));
                            _controller.clear();
                          }
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Le champ ne peux pas etre vide')));
                        }
                      },
                      child: Text("Modifier".toUpperCase()))
                ],
              )
            ],
          ),
        ),
      )
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => _modal(context),
        icon: const Icon(
      Icons.edit,
      color: Colors.green,
    ));
  }
}
