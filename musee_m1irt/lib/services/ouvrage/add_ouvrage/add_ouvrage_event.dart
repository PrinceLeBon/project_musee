part of 'add_ouvrage_bloc.dart';

abstract class AddOuvrageEvent extends Equatable {
  const AddOuvrageEvent();
}

class OnAddOuvrageEvent extends AddOuvrageEvent{
  final int ISBN;
  final int nbPage;
  final String titre;
  final String codePays;
  const OnAddOuvrageEvent({required this.ISBN, required this.nbPage, required this.titre, required this.codePays});
  @override
  // TODO: implement props
  List<Object?> get props => [ISBN,nbPage,titre, codePays];

}