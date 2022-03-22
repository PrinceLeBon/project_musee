import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/ouvrage_model.dart';
import 'package:musee_m1irt/repositories/ouvrage_repository.dart';

part 'remove_ouvrage_event.dart';
part 'remove_ouvrage_state.dart';

class RemoveOuvrageBloc extends Bloc<RemoveOuvrageEvent, RemoveOuvrageState> {
  final OuvrageRepository ouvrageRepository;
  RemoveOuvrageBloc(this.ouvrageRepository) : super(RemoveOuvrageInitial()) {
    on<OnRemoveOuvrageEvent>((event, emit) async{
      // TODO: implement event handler
      await ouvrageRepository.remove(event.ouvrageModel);

      emit(RemoveOuvrageSucessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
