import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/repositories/bibliotheque_repository.dart';

part 'add_bibliotheque_event.dart';
part 'add_bibliotheque_state.dart';

class AddBibliothequeBloc extends Bloc<AddBibliothequeEvent, AddBibliothequeState> {
  final BibliothequeRepository bibliothequeRepository;
  AddBibliothequeBloc(this.bibliothequeRepository) : super(AddBibliothequeInitial()) {
    on<OnAddBibliothequeEvent>((event, emit) async{
      // TODO: implement event handler
      await bibliothequeRepository.add({
        "numMus": event.numMus,
        "ISBN": event.ISBN,
        "dateAchat": event.dateAchat,
      });

      print(bibliothequeRepository.listbiblio);

      emit(AddBibliothequeSucessState(timestamp: DateTime.now().millisecondsSinceEpoch));
      print(bibliothequeRepository.listbiblio);
    });
  }
}
