import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/visiter_repository.dart';

part 'edit_visiter_event.dart';
part 'edit_visiter_state.dart';

class EditVisiterBloc extends Bloc<EditVisiterEvent, EditVisiterState> {
  final VisiterRepository visiterRepository;
  EditVisiterBloc(this.visiterRepository) : super(EditVisiterInitial()) {
    on<OnEditVisiterEvent>((event, emit) async{
      // TODO: implement event handler
      await visiterRepository.update({
        "numMus": event.numMus,
        "jour": event.jour,
        "nbvisiteurs": event.nbvisiteurs,
      },
          {
            "id": event.id,
            "numMus": event.numMus,
            "jour": event.jour,
            "nbvisiteurs": event.nbvisiteurs,
          }
      );
      emit(EditVisiterSuccessState(timestamp: DateTime.now().millisecondsSinceEpoch));

    });
  }
}
