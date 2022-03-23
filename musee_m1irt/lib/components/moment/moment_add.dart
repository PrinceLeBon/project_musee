import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/services/moment/add_moment/add_moment_bloc.dart';

class Moment_add extends StatefulWidget {
  const Moment_add({Key? key}) : super(key: key);

  @override
  _Moment_addState createState() => _Moment_addState();
}

class _Moment_addState extends State<Moment_add> {
  final TextEditingController _controller = TextEditingController();
  bool trouve = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _modal(BuildContext context) => showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) => BlocListener<AddMomentBloc, AddMomentState>(
        listener: (content, state){
          if (state is AddMomentSuccessState){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ajout effectué'),
                  duration: Duration(seconds: 1),
                )
            );
          }
        },
        child: SimpleDialog(
          title: Text(
            "Création de Moment".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration:
                const InputDecoration(hintText: 'Entre le jour'),
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
                            _controller.clear();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text(
                                    'Ce jour existe déjà')));
                          } else {
                            context.read<AddMomentBloc>().add(
                                OnAddMomentEvent(moment: _controller.text));
                            _controller.clear();
                          }
                        } else {
                          context.read<AddMomentBloc>().add(
                              OnAddMomentEvent(moment: _controller.text));
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
                    child: Text("Ajouter".toUpperCase()))
              ],
            )
          ],
        ),
      ))
  /*showModalBottomSheet(
      context: context,
      //blocklistener pour écouter une action
      builder: (context) => BlocListener<AddMomentBloc, AddMomentState>(
        listener: (content, state){
          if (state is AddMomentSuccessState){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ajout effectué'),
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
                  "Création de Moment".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration:
                  const InputDecoration(hintText: 'Entre le jour'),
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
                              _controller.clear();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Ce jour existe déjà')));
                            } else {
                              context.read<AddMomentBloc>().add(
                                  OnAddMomentEvent(moment: _controller.text));
                              _controller.clear();
                            }
                          } else {
                            context.read<AddMomentBloc>().add(
                                OnAddMomentEvent(moment: _controller.text));
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
                      child: Text("Ajouter".toUpperCase()))
                ],
              )
            ],
          ),
        ),
      )
  )*/;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _modal(context),
      child: const Icon(Icons.add),
    );
  }
}
