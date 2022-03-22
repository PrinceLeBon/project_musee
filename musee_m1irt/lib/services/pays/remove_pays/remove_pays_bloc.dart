import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/pays_model.dart';
import 'package:musee_m1irt/repositories/pays_repository.dart';

part 'remove_pays_event.dart';
part 'remove_pays_state.dart';

class RemovePaysBloc extends Bloc<RemovePaysEvent, RemovePaysState> {
  final PaysRepository paysRepository;
  RemovePaysBloc(this.paysRepository) : super(RemovePaysInitial()) {
    on<OnRemovePaysEvent>((event, emit) async{
      // TODO: implement event handler
      await paysRepository.remove(event.paysModel);

      emit(RemovePaysSucessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
