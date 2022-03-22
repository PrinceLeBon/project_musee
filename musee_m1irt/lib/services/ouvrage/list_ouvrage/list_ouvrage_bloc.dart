import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/ouvrage_model.dart';
import 'package:musee_m1irt/repositories/ouvrage_repository.dart';
import 'package:musee_m1irt/services/ouvrage/add_ouvrage/add_ouvrage_bloc.dart';

part 'list_ouvrage_event.dart';
part 'list_ouvrage_state.dart';

class ListOuvrageBloc extends Bloc<ListOuvrageEvent, ListOuvrageState> {
  final OuvrageRepository ouvrageRepository;
  ListOuvrageBloc(this.ouvrageRepository) : super(ListState(timestamp: DateTime.now().second, listouvrage: List<OuvrageModel>.from([]))) {
    ouvrageRepository.ouvrage.listen((ouvrage) {
      add(_OnOuvrageUpdatedListOuvrageEvent(ouvrage: ouvrage));
    });
    on<_OnOuvrageUpdatedListOuvrageEvent>((event, emit) {
      // TODO: implement event handler
      emit(ListState(timestamp: DateTime.now().second, listouvrage: event.ouvrage));
    });
  }
}
