import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/ouvrage_repository.dart';

part 'add_ouvrage_event.dart';
part 'add_ouvrage_state.dart';

class AddOuvrageBloc extends Bloc<AddOuvrageEvent, AddOuvrageState> {
  final OuvrageRepository ouvrageRepository;
  AddOuvrageBloc(this.ouvrageRepository) : super(AddOuvrageInitial()) {
    on<OnAddOuvrageEvent>((event, emit) async{
      // TODO: implement event handler
      await ouvrageRepository.add({
        "ISBN": event.ISBN,
        "nbPage": event.nbPage,
        "titre": event.titre,
        "codePays": event.codePays,
      });

      print(ouvrageRepository.listouvrage);

      emit(AddOuvrageSucessState(timestamp: DateTime.now().millisecondsSinceEpoch));
      print(ouvrageRepository.listouvrage);
    });
  }
}
