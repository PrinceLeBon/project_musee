import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/bibliotheque_model.dart';
import 'package:musee_m1irt/repositories/bibliotheque_repository.dart';

part 'list_bibliotheque_event.dart';
part 'list_bibliotheque_state.dart';

class ListBibliothequeBloc extends Bloc<ListBibliothequeEvent, ListBibliothequeState> {
  final BibliothequeRepository bibliothequeRepository;
  ListBibliothequeBloc(this.bibliothequeRepository) : super(ListState(timestamp: DateTime.now().second, listbiblio: List<BibliothequeModel>.from([]))) {

    bibliothequeRepository.biblio.listen((bibliotheque) {
      add(_OnBibliothequeUpdatedListBibliothequeEvent(bibliotheque: bibliotheque));
    });

    on<_OnBibliothequeUpdatedListBibliothequeEvent>((event, emit) {
      // TODO: implement event handler
      emit(ListState(timestamp: DateTime.now().second, listbiblio: event.bibliotheque));
    });
  }
}
