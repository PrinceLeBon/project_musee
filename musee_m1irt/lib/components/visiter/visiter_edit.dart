import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/globals.dart';
import 'package:musee_m1irt/models/moment_model.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/services/visiter/add_visiter/add_visiter_bloc.dart';
import 'package:musee_m1irt/services/visiter/edit_visiter/edit_visiter_bloc.dart';

class Visiter_edit extends StatefulWidget {
  final int id;
  final int num;
  final String jour;
  final int nbvisit;
  const Visiter_edit(this.id, this.num, this.jour, this.nbvisit,{Key? key}) : super(key: key);

  @override
  _Visiter_editState createState() => _Visiter_editState();
}

class _Visiter_editState extends State<Visiter_edit> {
   TextEditingController _controller1 = TextEditingController();
   TextEditingController _controller2 = TextEditingController();
   TextEditingController _controller3 = TextEditingController();
  late List<DropdownMenuItem<String>> _liste1 =[];
  late List<DropdownMenuItem<String>> _liste2 =[];
  late final int id;
  List<MuseeModel> listmusee = [];
  List<MomentModel> listmoment = [];
  bool trouve = true;
  var _value1;
  var _value2;

  @override
  void initState() {
    // TODO: implement initState
    id = widget.id;
    _controller1.text = widget.num.toString();
    _value1 = widget.num.toString();
    _value2 = widget.jour;
    _controller2.text = widget.jour;
    _controller3.text = widget.nbvisit.toString();
    remplir_listes();
    super.initState();
  }


  void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      //blocklistener pour écouter une action
      builder: (context) => BlocListener<EditVisiterBloc, EditVisiterState>(
        listener: (content, state) {
          if (state is EditVisiterSuccessState) {
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
                  "Modification d'une visite".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
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
                hint: Text("Jour"),
              ),
              champ_a_remplir(_controller3, "Nombre de visiteurs",
                  TextInputType.number),
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
                          context.read<EditVisiterBloc>().add(
                            OnEditVisiterEvent(
                                id: id,
                                numMus: int.parse(_value1),
                                jour: _value2,
                                nbvisiteurs: int.parse(_controller3.text)));
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
    for (int i = 0; i < global_list_moment.length; i++) {
      _liste2.add(DropdownMenuItem(
        child: Text(global_list_moment[i].jour),
        value: global_list_moment[i].jour,
      ));
    }
  }
}
