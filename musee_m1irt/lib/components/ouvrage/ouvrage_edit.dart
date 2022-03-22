import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/services/ouvrage/add_ouvrage/add_ouvrage_bloc.dart';
import 'package:musee_m1irt/services/ouvrage/edit_ouvrage/edit_ouvrage_bloc.dart';

class Ouvrage_edit extends StatefulWidget {
  final int isbn;
  final String titre;
  final int nbpage;
  final String code;
  const Ouvrage_edit(this.isbn, this.titre, this.nbpage, this.code,{Key? key}) : super(key: key);

  @override
  _Ouvrage_editState createState() => _Ouvrage_editState();
}

class _Ouvrage_editState extends State<Ouvrage_edit> {
   TextEditingController _controller1 = TextEditingController();
   TextEditingController _controller2 = TextEditingController();
   TextEditingController _controller3 = TextEditingController();
   TextEditingController _controller4 = TextEditingController();
  late List<DropdownMenuItem<String>> _liste =[];
   late final int isbn;
  List<PaysModel> listpays = [];
  bool trouve = true;
  var _value;

  @override
  void initState() {
    // TODO: implement initState
    remplir_listes();
    isbn = widget.isbn;
    _controller1.text = widget.isbn.toString();
    _controller2.text = widget.titre;
    _controller3.text = widget.nbpage.toString();
    _controller4.text = widget.code;
    _value = widget.code;
    super.initState();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      //blocklistener pour écouter une action
      builder: (context) => BlocListener<EditOuvrageBloc, EditOuvrageState>(
        listener: (content, state) {
          if (state is EditOuvrageSuccessState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Modification effectué'),
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
                  "Création d'un ouvrage".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
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
                          context.read<EditOuvrageBloc>().add(
                            OnEditOuvrageEvent(
                                ISBN: int.parse(_controller1.text),
                                ISBN1: isbn,
                                nbPage: int.parse(_controller3.text),
                                titre: _controller2.text,
                                codePays: _value));
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
          ),
        ),
      ));

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
    for (int i = 0; i < global_list_pays.length; i++) {
      _liste.add(DropdownMenuItem(
        child: Text(global_list_pays[i].codePays),
        value: global_list_pays[i].codePays,
      ));
    }
  }
}
