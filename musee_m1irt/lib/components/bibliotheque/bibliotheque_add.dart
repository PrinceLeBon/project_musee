import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/models/ouvrage_model.dart';
import 'package:musee_m1irt/services/bibliotheque/add_bibliotheque/add_bibliotheque_bloc.dart';

class Bibliotheque_add extends StatefulWidget {
  const Bibliotheque_add({Key? key}) : super(key: key);

  @override
  _Bibliotheque_addState createState() => _Bibliotheque_addState();
}

class _Bibliotheque_addState extends State<Bibliotheque_add> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  late List<DropdownMenuItem<String>> _liste1 =[];
  late List<DropdownMenuItem<String>> _liste2 =[];
  List<MuseeModel> listmusee = [];
  List<OuvrageModel> listouvrage = [];
  bool trouve = true;
  var _value1;
  var _value2;
  DateTime selectedDate = DateTime.now();

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

  void _modal(BuildContext context) => showDialog(
      context: context,
      builder: (context) => BlocListener<AddBibliothequeBloc, AddBibliothequeState>(
        listener: (content, state) {
          if (state is AddBibliothequeSucessState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ajout effectué'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        child: SimpleDialog(
          title: Text(
            "Création d'une bibliothèque".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          children: [
            DropdownButtonFormField<String>(
              value: _value1,
              items: _liste1,
              onChanged: (value) {
                setState(() {
                  _value1 = value;
                  _controller1.text = _value1;
                });

              },
              hint: Text("Numéro Musée"),
            ),
            DropdownButtonFormField<String>(
              value: _value2,
              items: _liste2,
              onChanged: (value) {
                setState(() {
                  _value2 = value;
                  _controller2.text = _value2;
                });

              },
              hint: Text("ISBN"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: const Text("Choisir une date"),
                )
              ],
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
                        context.read<AddBibliothequeBloc>().add(
                            OnAddBibliothequeEvent(
                                numMus: int.parse(_controller1.text),
                                ISBN: int.parse(_controller2.text),
                                dateAchat: _controller3.text));
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
        )
        ))
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

  remplir_listes(){
    for (int i = 0; i < global_list_musee.length; i++) {
      _liste1.add(DropdownMenuItem(
        child: Text("${global_list_musee[i].numMus} ${global_list_musee[i].nomMus}"),
        value: global_list_musee[i].numMus.toString(),
      ));
    }
    for (int i = 0; i < global_list_ouvrage.length; i++) {
      _liste2.add(DropdownMenuItem(
        child: Text("${global_list_ouvrage[i].ISBN}"),
        value: global_list_ouvrage[i].ISBN.toString(),
      ));
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2023),
      initialEntryMode: DatePickerEntryMode.input

    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        _controller3.text= "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }
}
