import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/bibliotheque_model.dart';
import 'package:musee_m1irt/repositories/bibliotheque_repository.dart';

part 'remove_bibliotheque_event.dart';
part 'remove_bibliotheque_state.dart';

class RemoveBibliothequeBloc extends Bloc<RemoveBibliothequeEvent, RemoveBibliothequeState> {
  final BibliothequeRepository bibliothequeRepository;
  RemoveBibliothequeBloc(this.bibliothequeRepository) : super(RemoveBibliothequeInitial()) {
    on<OnRemoveBibliothequeEvent>((event, emit) async{
      // TODO: implement event handler
      await bibliothequeRepository.remove(event.bibliothequeModel);

      emit(RemoveBibliothequeSucessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
