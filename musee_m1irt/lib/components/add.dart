import 'package:flutter/material.dart';
import 'package:musee_m1irt/components/bibliotheque/bibliotheque_add.dart';
import 'package:musee_m1irt/components/moment/moment_add.dart';
import 'package:musee_m1irt/components/musee/musee_add.dart';
import 'package:musee_m1irt/components/ouvrage/ouvrage_add.dart';
import 'package:musee_m1irt/components/pays/pays_add.dart';
import 'package:musee_m1irt/components/visiter/visiter_add.dart';
class Add extends StatelessWidget {
  int page;
   Add(this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(page);
    switch (page){
      case 0:
        return const Moment_add();
      case 1:
        return const Pays_add();
      case 2:
        return const Musee_add();
      case 3:
        return const Bibliotheque_add();
      case 4:
        return const Visiter_add();
      case 5:
        return const Ouvrage_add();

    }
    return Container();
  }
}
