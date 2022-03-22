import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/musee_model.dart';
import 'package:musee_m1irt/repositories/musee_repository.dart';

part 'remove_musee_event.dart';
part 'remove_musee_state.dart';

class RemoveMuseeBloc extends Bloc<RemoveMuseeEvent, RemoveMuseeState> {
  final MuseeRepository museeRepository;
  RemoveMuseeBloc(this.museeRepository) : super(RemoveMuseeInitial()) {
    on<OnRemoveMuseeEvent>((event, emit) async{
      // TODO: implement event handler
      await museeRepository.remove(event.museeModel);

      emit(RemoveMuseeSucessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
