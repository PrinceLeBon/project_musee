part of 'edit_ouvrage_bloc.dart';

abstract class EditOuvrageEvent extends Equatable {
  const EditOuvrageEvent();
}

class OnEditOuvrageEvent extends EditOuvrageEvent{
  final int ISBN, ISBN1;
  final int nbPage;
  final String titre;
  final String codePays;
  const OnEditOuvrageEvent({required this.ISBN, required this.ISBN1,required this.nbPage,
    required this.titre, required this.codePays});
  @override
  // TODO: implement props
  List<Object?> get props => [ISBN1, ISBN,nbPage,titre, codePays];
}