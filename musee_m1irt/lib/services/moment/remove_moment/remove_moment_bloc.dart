import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/moment_model.dart';
import 'package:musee_m1irt/repositories/moment_repository.dart';

part 'remove_moment_event.dart';
part 'remove_moment_state.dart';

class RemoveMomentBloc extends Bloc<RemoveMomentEvent, RemoveMomentState> {
  final MomentRepository momentRepository;
  RemoveMomentBloc(this.momentRepository) : super(RemoveMomentInitial()) {
    on<OnRemoveMomentEvent>((event, emit) async{
      // TODO: implement event handler
      await momentRepository.remove(event.momentModel);

      emit(RemoveMomentSucessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
