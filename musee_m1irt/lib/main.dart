import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musee_m1irt/repositories/bibliotheque_repository.dart';
import 'package:musee_m1irt/repositories/moment_repository.dart';
import 'package:musee_m1irt/repositories/musee_repository.dart';
import 'package:musee_m1irt/repositories/ouvrage_repository.dart';
import 'package:musee_m1irt/repositories/pays_repository.dart';
import 'package:musee_m1irt/repositories/visiter_repository.dart';
import 'package:musee_m1irt/screens/home_screen.dart';
import 'package:musee_m1irt/services/bibliotheque/add_bibliotheque/add_bibliotheque_bloc.dart';
import 'package:musee_m1irt/services/bibliotheque/edit_bibliotheque/edit_bibliotheque_bloc.dart';
import 'package:musee_m1irt/services/bibliotheque/list_bibliotheque/list_bibliotheque_bloc.dart';
import 'package:musee_m1irt/services/bibliotheque/remove_bibliotheque/remove_bibliotheque_bloc.dart';
import 'package:musee_m1irt/services/moment/add_moment/add_moment_bloc.dart';
import 'package:musee_m1irt/services/moment/edit_moment/edit_moment_bloc.dart';
import 'package:musee_m1irt/services/moment/list_moment/list_moment_bloc.dart';
import 'package:musee_m1irt/services/moment/remove_moment/remove_moment_bloc.dart';
import 'package:musee_m1irt/services/musee/add_musee/add_musee_bloc.dart';
import 'package:musee_m1irt/services/musee/edit_musee/edit_musee_bloc.dart';
import 'package:musee_m1irt/services/musee/list_musee/list_musee_bloc.dart';
import 'package:musee_m1irt/services/musee/remove_musee/remove_musee_bloc.dart';
import 'package:musee_m1irt/services/ouvrage/add_ouvrage/add_ouvrage_bloc.dart';
import 'package:musee_m1irt/services/ouvrage/edit_ouvrage/edit_ouvrage_bloc.dart';
import 'package:musee_m1irt/services/ouvrage/list_ouvrage/list_ouvrage_bloc.dart';
import 'package:musee_m1irt/services/ouvrage/remove_ouvrage/remove_ouvrage_bloc.dart';
import 'package:musee_m1irt/services/pays/add_pays/add_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/edit_pays/edit_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/list_pays/list_pays_bloc.dart';
import 'package:musee_m1irt/services/pays/remove_pays/remove_pays_bloc.dart';
import 'package:musee_m1irt/services/visiter/add_visiter/add_visiter_bloc.dart';
import 'package:musee_m1irt/services/visiter/edit_visiter/edit_visiter_bloc.dart';
import 'package:musee_m1irt/services/visiter/list_visiter/list_visiter_bloc.dart';
import 'package:musee_m1irt/services/visiter/remove_visiter/remove_visiter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'museum.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE Pays (codePays TEXT PRIMARY KEY, nbhabitant INTEGER, UNIQUE(codePays))',
      );
      await db.execute(
          'CREATE TABLE Musee (numMus INTEGER PRIMARY KEY, nomMus TEXT, nblivres INTEGER, codePays TEXT REFERENCES Pays(codePays) ON DELETE CASCADE ON UPDATE CASCADE)');
      await db.execute('CREATE TABLE Moment (jour TEXT PRIMARY KEY, UNIQUE(jour))');
      await db.execute(
        'CREATE TABLE Visiter (id INTEGER, numMus INTEGER REFERENCES Musee(numMus) ON DELETE CASCADE ON UPDATE CASCADE, jour TEXT REFERENCES Moment(jour) ON DELETE CASCADE ON UPDATE CASCADE, nbvisiteurs INTEGER, PRIMARY KEY(numMus, jour))',
      );
      await db.execute(
        'CREATE TABLE Ouvrage (ISBN INTEGER PRIMARY KEY, nbPage INTEGER, titre TEXT, codePays TEXT REFERENCES Pays(codePays) ON DELETE CASCADE ON UPDATE CASCADE, UNIQUE(ISBN))',
      );
      await db.execute(
        'CREATE TABLE Bibliotheque (id INTEGER, numMus INTEGER REFERENCES Musee(numMus) ON DELETE CASCADE ON UPDATE CASCADE, ISBN INTEGER REFERENCES Ouvrage(ISBN) ON DELETE CASCADE ON UPDATE CASCADE, dateAchat TEXT, PRIMARY KEY(numMus, ISBN))',
      );
    },
    version: 1,
  );

  final MomentRepository momentRepository =
      MomentRepository(database: await database);
  final PaysRepository paysRepository =
  PaysRepository (database: await database);
  final MuseeRepository museeRepository =
  MuseeRepository (database: await database);
  final BibliothequeRepository bibliothequeRepository =
  BibliothequeRepository (database: await database);
  final VisiterRepository visiterRepository =
  VisiterRepository (database: await database);
  final OuvrageRepository ouvrageRepository =
  OuvrageRepository (database: await database);

  momentRepository.initialize();
  paysRepository.initialize();
  museeRepository.initialize();
  bibliothequeRepository.initialize();
  visiterRepository.initialize();
  ouvrageRepository.initialize();

  runApp(MyApp(
    momentRepository: momentRepository,
    paysRepository: paysRepository,
    museeRepository: museeRepository,
    bibliothequeRepository: bibliothequeRepository,
    visiterRepository: visiterRepository,
    ouvrageRepository: ouvrageRepository,
  ));
}

class MyApp extends StatelessWidget {
  final MomentRepository momentRepository;
  final PaysRepository paysRepository;
  final MuseeRepository museeRepository;
  final VisiterRepository visiterRepository;
  final BibliothequeRepository bibliothequeRepository;
  final OuvrageRepository ouvrageRepository;

  const MyApp({Key? key,
    required this.momentRepository,
    required this.paysRepository,
    required this.museeRepository,
    required this.bibliothequeRepository,
    required this.visiterRepository,
    required this.ouvrageRepository
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ListMomentBloc>(
              lazy: false,
              create: (context)  => ListMomentBloc(momentRepository)
          ),
          BlocProvider(
              create: (context)  => AddMomentBloc(momentRepository)
          ),
          BlocProvider(
              create: (context)  => RemoveMomentBloc(momentRepository)
          ),
          BlocProvider(
              create: (context)  => EditMomentBloc(momentRepository)
          ),

          BlocProvider<ListPaysBloc>(
              lazy: false,
              create: (context)  => ListPaysBloc(paysRepository)
          ),
          BlocProvider(
              create: (context)  => AddPaysBloc(paysRepository)
          ),
          BlocProvider(
              create: (context)  => RemovePaysBloc(paysRepository)
          ),
          BlocProvider(
              create: (context)  => EditPaysBloc(paysRepository)
          ),

          BlocProvider<ListMuseeBloc>(
              lazy: false,
              create: (context)  => ListMuseeBloc(museeRepository)
          ),
          BlocProvider(
              create: (context)  => AddMuseeBloc(museeRepository)
          ),
          BlocProvider(
              create: (context)  => RemoveMuseeBloc(museeRepository)
          ),
          BlocProvider(
              create: (context)  => EditMuseeBloc(museeRepository)
          ),

          BlocProvider<ListVisiterBloc>(
              lazy: false,
              create: (context)  => ListVisiterBloc(visiterRepository)
          ),
          BlocProvider(
              create: (context)  => AddVisiterBloc(visiterRepository)
          ),
          BlocProvider(
              create: (context)  => RemoveVisiterBloc(visiterRepository)
          ),
          BlocProvider(
              create: (context)  => EditVisiterBloc(visiterRepository)
          ),

          BlocProvider<ListBibliothequeBloc>(
              lazy: false,
              create: (context)  => ListBibliothequeBloc(bibliothequeRepository)
          ),
          BlocProvider(
              create: (context)  => AddBibliothequeBloc(bibliothequeRepository)
          ),
          BlocProvider(
              create: (context)  => RemoveBibliothequeBloc(bibliothequeRepository)
          ),
          BlocProvider(
              create: (context)  => EditBibliothequeBloc(bibliothequeRepository)
          ),

          BlocProvider<ListOuvrageBloc>(
              lazy: false,
              create: (context)  => ListOuvrageBloc(ouvrageRepository)
          ),
          BlocProvider(
              create: (context)  => AddOuvrageBloc(ouvrageRepository)
          ),
          BlocProvider(
              create: (context)  => RemoveOuvrageBloc(ouvrageRepository)
          ),
          BlocProvider(
              create: (context)  => EditOuvrageBloc(ouvrageRepository)
          ),
        ],
        child: const MaterialApp(
          title: 'Museum',
          debugShowCheckedModeBanner: false,
          home: home_screen(),
        ));
  }
}
