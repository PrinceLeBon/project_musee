import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/repositories/musee_repository.dart';

part 'list_musee_event.dart';
part 'list_musee_state.dart';

class ListMuseeBloc extends Bloc<ListMuseeEvent, ListMuseeState> {
  final MuseeRepository museeRepository;
  ListMuseeBloc(this.museeRepository) : super(ListState(timestamp: DateTime.now().second, listmusee: List<MuseeModel>.from([]))) {

    museeRepository.musee.listen((musee) {
      add(_OnMuseeUpdatedListMuseeEvent(musee: musee));
    });
    on<_OnMuseeUpdatedListMuseeEvent>((event, emit) {
      // TODO: implement event handler
      emit(ListState(timestamp: DateTime.now().second, listmusee: event.musee));
    });
  }
}
