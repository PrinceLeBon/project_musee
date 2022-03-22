import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/moment_model.dart';
import 'package:musee_m1irt/repositories/moment_repository.dart';

part 'list_moment_event.dart';
part 'list_moment_state.dart';

class ListMomentBloc extends Bloc<ListMomentEvent, ListMomentState> {
  final MomentRepository momentRepository;

  ListMomentBloc(this.momentRepository) : super(ListState(timestamp: DateTime.now().second, listmoment: List<MomentModel>.from([]))) {

    momentRepository.moment.listen((moment) {
      add(_OnMomentUpdatedListMomentEvent(moment: moment));
    });

    on<_OnMomentUpdatedListMomentEvent>((event, emit) {
      // TODO: implement event handler

      emit(ListState(timestamp: DateTime.now().second, listmoment: event.moment));
    });
  }
}
