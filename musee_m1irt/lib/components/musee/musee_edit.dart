import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/services/musee/add_musee/add_musee_bloc.dart';
import 'package:musee_m1irt/services/musee/edit_musee/edit_musee_bloc.dart';

class Musee_edit extends StatefulWidget {
  final int num;
  final String nom;
  final int nblivre;
  final String codepays;
  const Musee_edit(this.num, this.nom, this.nblivre, this.codepays,{Key? key}) : super(key: key);

  @override
  _Musee_editState createState() => _Musee_editState();
}

class _Musee_editState extends State<Musee_edit> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
   TextEditingController _controller3 = TextEditingController();
   List<DropdownMenuItem<String>> _liste =[];
   late final int num;
  List<PaysModel> listpays = [];
  List<MuseeModel> listmodel = [];
  bool trouve = true;
  var _value;

  @override
  void initState() {
    // TODO: implement initState
    _value = widget.codepays;
    _controller3.text = widget.codepays;
    _controller1.text = widget.nom;
    _controller2.text = widget.nblivre.toString();
    num = widget.num;
    remplir_listes();
    super.initState();
  }

  void _modal(BuildContext context) =>
  showDialog(
      context: context,
      builder: (context) => BlocListener<EditMuseeBloc, EditMuseeState>(
          listener: (content, state) {
            if (state is EditMuseeSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Modification effectué'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          child: SimpleDialog(
            title: Text(
              "Modification d'un musée".toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
            children: [
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
                          context.read<EditMuseeBloc>().add(
                              OnEditMuseeEvent(
                                  numMus: num,
                                  nomMus: _controller1.text,
                                  nomMus1: _controller1.text,
                                  nblivres: int.parse(_controller2.text),
                                  nblivres1: int.parse(_controller2.text),
                                  codePays: _value,
                                  codePays1: _value));
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
                      child: Text("Modifier".toUpperCase()))
                ],
              )
            ],
          ))
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
    for (int i = 0; i < global_list_pays.length; i++) {
      _liste.add(DropdownMenuItem(
        child: Text(global_list_pays[i].codePays),
        value: global_list_pays[i].codePays,
      ));
    }
  }
}
