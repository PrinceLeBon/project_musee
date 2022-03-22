import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/visiter_repository.dart';

part 'add_visiter_event.dart';
part 'add_visiter_state.dart';

class AddVisiterBloc extends Bloc<AddVisiterEvent, AddVisiterState> {
  final VisiterRepository visiterRepository;
  AddVisiterBloc(this.visiterRepository) : super(AddVisiterInitial()) {
    on<OnAddVisiterEvent>((event, emit) async{
      // TODO: implement event handler
      await visiterRepository.add({
        "numMus": event.numMus,
        "jour": event.jour,
        "nbvisiteurs": event.nbvisiteurs,
      });

      print(visiterRepository.listvisiter);

      emit(AddVisiterSucessState(timestamp: DateTime.now().millisecondsSinceEpoch));
      print(visiterRepository.listvisiter);
    });
  }
}
