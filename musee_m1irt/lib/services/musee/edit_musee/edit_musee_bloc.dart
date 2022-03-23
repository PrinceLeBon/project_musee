import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/musee_repository.dart';

part 'edit_musee_event.dart';
part 'edit_musee_state.dart';

class EditMuseeBloc extends Bloc<EditMuseeEvent, EditMuseeState> {
  final MuseeRepository museeRepository;
  EditMuseeBloc(this.museeRepository) : super(EditMuseeInitial()) {
    on<OnEditMuseeEvent>((event, emit) async{
      // TODO: implement event handler
      await museeRepository.update({
        "numMus": event.numMus,
        "nomMus": event.nomMus,
        "nblivres": event.nblivres,
        "codePays": event.codePays,
      },
          {
            "numMus": event.numMus,
            "nomMus": event.nomMus1,
            "nblivres": event.nblivres1,
            "codePays": event.codePays1,
          }
      );

      emit(EditMuseeSuccessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
