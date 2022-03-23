import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/models/ouvrage_model.dart';
import 'package:musee_m1irt/services/bibliotheque/add_bibliotheque/add_bibliotheque_bloc.dart';
import 'package:musee_m1irt/services/bibliotheque/edit_bibliotheque/edit_bibliotheque_bloc.dart';

class Bibliotheque_edit extends StatefulWidget {
  final int id;
  final int num;
  final int isbn;
  final String date;
  const Bibliotheque_edit(this.id, this.num, this.isbn, this.date, {Key? key}) : super(key: key);

  @override
  _Bibliotheque_editState createState() => _Bibliotheque_editState();
}

class _Bibliotheque_editState extends State<Bibliotheque_edit> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  late final int id;
  late List<DropdownMenuItem<String>> _liste1 =[];
  late List<DropdownMenuItem<String>> _liste2 =[];
  List<MuseeModel> listmusee = [];
  List<OuvrageModel> listouvrage = [];
  var _split;
  bool trouve = true;
  var _value1;
  var _value2;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    _value1 = widget.num.toString();
    _controller1.text = widget.num.toString();
    _value2 = widget.isbn.toString();
    _controller2.text = widget.isbn.toString();
    id = widget.id;
    _split = widget.date.split("/");
    selectedDate = DateTime(int.parse(_split[2]), int.parse(_split[1]), int.parse(_split[0]));
    _controller3.text= "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    remplir_listes();
    super.initState();
  }

  void _modal(BuildContext context) => showDialog(
      context: context,
      builder: (context) => BlocListener<EditBibliothequeBloc, EditBibliothequeState>(
          listener: (content, state) {
            if (state is EditBibliothequeSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Modifiaction effectué'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          child: SimpleDialog(
            title: Text(
              "Modification d'une bibliothèque".toUpperCase(),
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
                          context.read<EditBibliothequeBloc>().add(
                              OnEditBibliothequeEvent(
                                  id: id,
                                  numMus: int.parse(_value1),
                                  numMus1: int.parse(_value1),
                                  ISBN: int.parse(_value2),
                                  dateAchat: _controller3.text));
                          _controller1.clear();
                          _controller2.clear();
                          _controller3.clear();
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content: Text(
                                  'Aucun champ ne doit etre vide')));
                        }
                      },
                      child: Text("Modifier".toUpperCase()))
                ],
              )
            ],
          )
        )
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _modal(context),
      icon: const Icon(
        Icons.edit,
        color: Colors.green,
      ),
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
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
        initialEntryMode: DatePickerEntryMode.input

    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        _controller3.text= "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }
}
