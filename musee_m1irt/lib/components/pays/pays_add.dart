import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/services/pays/add_pays/add_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/list_pays/list_pays_bloc.dart';

class Pays_add extends StatefulWidget {
  const Pays_add({Key? key}) : super(key: key);

  @override
  _Pays_addState createState() => _Pays_addState();
}

class _Pays_addState extends State<Pays_add> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  List<PaysModel> listpays = [];
  bool trouve = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _modal(BuildContext context) => showDialog(
      context: context,
      builder: (context) => BlocListener<AddPaysBloc, AddPaysState>(
        listener: (content, state) {
          if (state is AddPaysSucessState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ajout effectué'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        child: SimpleDialog(
          title: Text(
            "Création d'un pays".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          children: [
            champ_a_remplir(_controller1, 'Entre le code du pays',
                TextInputType.text),
            champ_a_remplir(_controller2, "Nombre d'habitants",
                TextInputType.number),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _controller1.clear();
                      _controller2.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Anuuler".toUpperCase())),
                TextButton(
                    onPressed: () {
                      if (_controller1.text.isNotEmpty &&
                          _controller2.text.isNotEmpty) {
                        if (listpays.isNotEmpty) {
                          for (int i = 0; i < listpays.length; i++) {
                            if ((listpays[i].codePays ==
                                _controller1.text.toUpperCase())){
                              (trouve = true);
                              break;
                            }else {
                              (trouve = false);
                            }
                          }
                          if (trouve) {
                            _controller1.clear();
                            _controller2.clear();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text(
                                    'Deux pays ne peuvent pas avoir le meme code')));
                          } else {
                            context.read<AddPaysBloc>().add(
                                OnAddPaysEvent(
                                    codePays: _controller1.text
                                        .toUpperCase(),
                                    nbhabitant: int.parse(
                                        _controller2.text)));
                            _controller1.clear();
                            _controller2.clear();
                          }
                        } else {
                          context.read<AddPaysBloc>().add(
                              OnAddPaysEvent(
                                  codePays:
                                  _controller1.text.toUpperCase(),
                                  nbhabitant:
                                  int.parse(_controller2.text)));
                          _controller1.clear();
                          _controller2.clear();
                        }
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Aucun champ ne doit etre vide')));
                      }
                    },
                    child: Text("Ajouter".toUpperCase()))
              ],
            )
          ],
        )))
        ;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _modal(context),
      child: const Icon(Icons.add),
    );
  }

  Widget champ_a_remplir(TextEditingController _controller, String libelle,
      TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: libelle),
          keyboardType: textInputType),
    );
  }
}
