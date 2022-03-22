part of 'add_bibliotheque_bloc.dart';

abstract class AddBibliothequeEvent extends Equatable {
  const AddBibliothequeEvent();
}

class OnAddBibliothequeEvent extends AddBibliothequeEvent{
  final int numMus;
  final int ISBN;
  final String dateAchat;
  const OnAddBibliothequeEvent({required this.numMus, required this.ISBN, required this.dateAchat});
  @override
  // TODO: implement props
  List<Object?> get props => [numMus,ISBN,dateAchat];

}