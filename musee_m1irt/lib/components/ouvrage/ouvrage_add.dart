import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/services/ouvrage/add_ouvrage/add_ouvrage_bloc.dart';

class Ouvrage_add extends StatefulWidget {
  const Ouvrage_add({Key? key}) : super(key: key);

  @override
  _Ouvrage_addState createState() => _Ouvrage_addState();
}

class _Ouvrage_addState extends State<Ouvrage_add> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  late List<DropdownMenuItem<String>> _liste =[];
  List<PaysModel> listpays = [];
  bool trouve = true;
  var _value;

  @override
  void initState() {
    // TODO: implement initState
    remplir_listes();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  void _modal(BuildContext context) => showDialog(
      context: context,
      builder: (context) => BlocListener<AddOuvrageBloc, AddOuvrageState>(
          listener: (content, state) {
            if (state is AddOuvrageSucessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Ajout effectué'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          child: SimpleDialog(
          title: Text(
            "Création d'un ouvrage".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
            children: [
              champ_a_remplir(
                  _controller1, "ISBN", TextInputType.number),
              champ_a_remplir(_controller2, "Titre",
                  TextInputType.text),
              champ_a_remplir(_controller3, "Nombre de pages",
                  TextInputType.number),
              DropdownButtonFormField<String>(
                value: _value,
                items: _liste,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                    _controller4.text = _value;
                  });

                },
                hint: Text("Code Pays"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _controller1.clear();
                        _controller2.clear();
                        _controller3.clear();
                        _controller4.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Anuuler".toUpperCase())),
                  TextButton(
                      onPressed: () {
                        if (_controller1.text.isNotEmpty &&
                            _controller2.text.isNotEmpty &&
                            _controller3.text.isNotEmpty && _controller4.text.isNotEmpty) {
                          context.read<AddOuvrageBloc>().add(
                              OnAddOuvrageEvent(
                                  ISBN: int.parse(_controller1.text),
                                  nbPage: int.parse(_controller3.text),
                                  titre: _controller2.text,
                                  codePays: _controller4.text));

                          _controller1.clear();
                          _controller2.clear();
                          _controller3.clear();
                          _controller4.clear();
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content: Text(
                                  'Aucun champ ne doit etre vide')));
                        }
                      },
                      child: Text("Ajouter".toUpperCase()))
                ],
              )
            ],
        )));

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

  remplir_listes(){
    for (int i = 0; i < global_list_pays.length; i++) {
      _liste.add(DropdownMenuItem(
        child: Text(global_list_pays[i].codePays),
        value: global_list_pays[i].codePays,
      ));
    }
  }
}
