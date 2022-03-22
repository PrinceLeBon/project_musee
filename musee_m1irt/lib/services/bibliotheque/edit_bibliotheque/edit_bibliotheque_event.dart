part of 'edit_bibliotheque_bloc.dart';

abstract class EditBibliothequeEvent extends Equatable {
  const EditBibliothequeEvent();
}

class OnEditBibliothequeEvent extends EditBibliothequeEvent{
  final int numMus, numMus1;
  final int id;
  final int ISBN;
  final String dateAchat;
  const OnEditBibliothequeEvent({ required this.id,
    required this.numMus,required this.numMus1, required this.ISBN, required this.dateAchat});
  @override
  // TODO: implement props
  List<Object?> get props => [id,numMus,ISBN,dateAchat, numMus1];

}