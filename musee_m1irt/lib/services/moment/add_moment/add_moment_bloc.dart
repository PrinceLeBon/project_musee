import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/moment_repository.dart';

part 'add_moment_event.dart';
part 'add_moment_state.dart';

class AddMomentBloc extends Bloc<AddMomentEvent, AddMomentState> {
  final MomentRepository momentRepository;

  AddMomentBloc(this.momentRepository) : super(AddMomentInitial()) {
    on<OnAddMomentEvent>((event, emit) async {
      // TODO: implement event handler
      await momentRepository.add({
        "jour": event.moment
      });

      print(momentRepository.listmoment);

      emit(AddMomentSuccessState(
          timestamp: DateTime.now().millisecondsSinceEpoch));
          print(momentRepository.listmoment);
    });
  }
}
