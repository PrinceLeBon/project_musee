import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/musee_repository.dart';

part 'add_musee_event.dart';
part 'add_musee_state.dart';

class AddMuseeBloc extends Bloc<AddMuseeEvent, AddMuseeState> {
  final MuseeRepository museeRepository;
  AddMuseeBloc(this.museeRepository) : super(AddMuseeInitial()) {
    on<OnAddMuseeEvent>((event, emit) async{
      // TODO: implement event handler
      await museeRepository.add({
        "nomMus": event.nomMus,
        "nblivres": event.nblivres,
        "codePays": event.codePays,
      });

      print(museeRepository.listmusee);

      emit(AddMuseeSucessState(timestamp: DateTime.now().millisecondsSinceEpoch));
      print(museeRepository.listmusee);
    });
  }
}
