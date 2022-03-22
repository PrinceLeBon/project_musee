import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/repositories/pays_repository.dart';

part 'list_pays_event.dart';
part 'list_pays_state.dart';

class ListPaysBloc extends Bloc<ListPaysEvent, ListPaysState> {
  final PaysRepository paysRepository;
  ListPaysBloc(this.paysRepository) : super(ListState(timestamp: DateTime.now().second, listpays: List<PaysModel>.from([]))) {

    paysRepository.pays.listen((pays) {
      add(_OnPaysUpdatedListPaysEvent(pays: pays));
    });

    on<_OnPaysUpdatedListPaysEvent>((event, emit) {
      // TODO: implement event handler
      emit(ListState(timestamp: DateTime.now().second, listpays: event.pays));
    });
  }
}
