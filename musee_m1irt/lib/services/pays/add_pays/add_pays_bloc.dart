import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/pays_repository.dart';

part 'add_pays_event.dart';
part 'add_pays_state.dart';

class AddPaysBloc extends Bloc<AddPaysEvent, AddPaysState> {
  final PaysRepository paysRepository;
  AddPaysBloc(this.paysRepository) : super(AddPaysInitial()) {
    on<OnAddPaysEvent>((event, emit) async{
      // TODO: implement event handler
      await paysRepository.add({
        "codePays": event.codePays,
        "nbhabitant": event.nbhabitant
      });

      print(paysRepository.listpays);

      emit(AddPaysSucessState(timestamp: DateTime.now().millisecondsSinceEpoch));
      print(paysRepository.listpays);

    });
  }
}
