import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/services/musee/add_musee/add_musee_bloc.dart';
import 'package:musee_m1irt/services/pays/list_pays/list_pays_bloc.dart';

class Musee_add extends StatefulWidget {
  const Musee_add({Key? key}) : super(key: key);

  @override
  _Musee_addState createState() => _Musee_addState();
}

class _Musee_addState extends State<Musee_add> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  late List<DropdownMenuItem<String>> _liste =[];
  List<PaysModel> listpays = [];
  List<MuseeModel> listmodel = [];
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
    super.dispose();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      //blocklistener pour écouter une action
      builder: (context) => BlocListener<AddMuseeBloc, AddMuseeState>(
            listener: (content, state) {
              if (state is AddMuseeSucessState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Ajout effectué'),
                  duration: Duration(seconds: 1),
                ));
              }
            },
            child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Création d'un musée".toUpperCase(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          champ_a_remplir(
                              _controller1, "Nom du musée", TextInputType.text),
                          champ_a_remplir(_controller2, "Nombre de livres",
                              TextInputType.number),
                          DropdownButtonFormField<String>(
                            value: _value,
                            items: _liste,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                                _controller3.text = _value;
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
                                    Navigator.pop(context);
                                  },
                                  child: Text("Anuuler".toUpperCase())),
                              TextButton(
                                  onPressed: () {
                                    if (_controller1.text.isNotEmpty &&
                                        _controller2.text.isNotEmpty &&
                                        _controller3.text.isNotEmpty) {
                                      context.read<AddMuseeBloc>().add(
                                          OnAddMuseeEvent(
                                              nomMus: _controller1.text,
                                              codePays: _controller3.text
                                                  .toUpperCase(),
                                              nblivres: int.parse(
                                                  _controller2.text)));
                                      _controller1.clear();
                                      _controller2.clear();
                                      _controller3.clear();
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
                      ),
                    ),
          ));

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
