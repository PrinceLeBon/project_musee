import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/ouvrage_repository.dart';

part 'edit_ouvrage_event.dart';
part 'edit_ouvrage_state.dart';

class EditOuvrageBloc extends Bloc<EditOuvrageEvent, EditOuvrageState> {
  final OuvrageRepository ouvrageRepository;
  EditOuvrageBloc(this.ouvrageRepository) : super(EditOuvrageInitial()) {
    on<OnEditOuvrageEvent>((event, emit) async{
      // TODO: implement event handler
      await ouvrageRepository.update({
        "ISBN": event.ISBN,
        "titre": event.titre,
        "nbPage": event.nbPage,
        "codePays": event.codePays
      },
          {
            "ISBN": event.ISBN1,
            "titre": event.titre,
            "nbPage": event.nbPage,
            "codePays": event.codePays
          }
      );
      emit(EditOuvrageSuccessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
