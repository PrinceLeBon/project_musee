import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/pays_repository.dart';

part 'edit_pays_event.dart';
part 'edit_pays_state.dart';

class EditPaysBloc extends Bloc<EditPaysEvent, EditPaysState> {
  final PaysRepository paysRepository;
  EditPaysBloc(this.paysRepository) : super(EditPaysInitial()) {
    on<OnEditPaysEvent>((event, emit) async{
      // TODO: implement event handler
      await paysRepository.update({
        "codePays": event.codePays,
        "nbhabitant": event.nbhabitant
      },
          {
        "codePays": event.codePays1,
        "nbhabitant": event.nbhabitant
      });

      emit(EditPaysSuccessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
