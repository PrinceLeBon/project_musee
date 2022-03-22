import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/visiter_model.dart';
import 'package:musee_m1irt/repositories/visiter_repository.dart';

part 'list_visiter_event.dart';
part 'list_visiter_state.dart';

class ListVisiterBloc extends Bloc<ListVisiterEvent, ListVisiterState> {
  final VisiterRepository visiterRepository;
  ListVisiterBloc(this.visiterRepository) : super(ListState(timestamp: DateTime.now().second, listvisiter: List<VisiterModel>.from([]))) {
    visiterRepository.visiter.listen((visiter) {
      add(_OnVisiterUpdatedListVisiterEvent(visiter: visiter));
    });

    on<_OnVisiterUpdatedListVisiterEvent>((event, emit) {
      // TODO: implement event handler
      emit(ListState(timestamp: DateTime.now().second, listvisiter: event.visiter));

    });
  }
}
