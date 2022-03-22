import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/bibliotheque_repository.dart';

part 'edit_bibliotheque_event.dart';
part 'edit_bibliotheque_state.dart';

class EditBibliothequeBloc extends Bloc<EditBibliothequeEvent, EditBibliothequeState> {
  final BibliothequeRepository bibliothequeRepository;
  EditBibliothequeBloc(this.bibliothequeRepository) : super(EditBibliothequeInitial()) {
    on<OnEditBibliothequeEvent>((event, emit) async{
      // TODO: implement event handler
      await bibliothequeRepository.update({
        "numMus": event.numMus,
        "ISBN": event.ISBN,
        "dateAchat": event.dateAchat,
      },
          {
            "id": event.id,
            "numMus": event.numMus,
            "ISBN": event.ISBN,
            "dateAchat": event.dateAchat,
          }
      );
      emit(EditBibliothequeSuccessState(timestamp: DateTime.now().millisecondsSinceEpoch));
    });
  }
}
