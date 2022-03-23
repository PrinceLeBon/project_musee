import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/services/pays/add_pays/add_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/edit_pays/edit_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/list_pays/list_pays_bloc.dart';

class Pays_edit extends StatefulWidget {
  final String code;
  final int nbh;
  const Pays_edit(this.code, this.nbh,{Key? key}) : super(key: key);
  @override
  _Pays_editState createState() => _Pays_editState();
}

class _Pays_editState extends State<Pays_edit> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  List<PaysModel> listpays = [];
  bool trouve = true;
  late final String codepays;

  @override
  void initState() {
    // TODO: implement initState
    _controller1.text = widget.code;
    _controller2.text = widget.nbh.toString();
    codepays = widget.code;
    super.initState();
  }

  void _modal(BuildContext context) => showDialog(
      context: context,
      builder: (context) => BlocListener<EditPaysBloc, EditPaysState>(
          listener: (content, state) {
            if (state is EditPaysSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Modification effectué'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          child: SimpleDialog(
            title: Text(
              "Modification d'un pays".toUpperCase(),
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
                              context.read<EditPaysBloc>().add(
                                  OnEditPaysEvent(
                                      codePays: _controller1.text.toUpperCase(),
                                      codePays1: codepays,
                                      nbhabitant: int.parse(_controller2.text)));
                              _controller1.clear();
                              _controller2.clear();
                            }
                          } else {
                            context.read<EditPaysBloc>().add(
                                OnEditPaysEvent(
                                    codePays: _controller1.text.toUpperCase(),
                                    codePays1: codepays,
                                    nbhabitant: int.parse(_controller2.text)));
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
                      child: Text("Modifier".toUpperCase()))
                ],
              )
            ],
          )
  ));

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => _modal(context),
        icon: const Icon(
          Icons.edit,
          color: Colors.green,
        ));
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
