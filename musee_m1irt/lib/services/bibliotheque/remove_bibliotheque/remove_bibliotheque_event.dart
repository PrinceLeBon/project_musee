part of 'remove_bibliotheque_bloc.dart';

abstract class RemoveBibliothequeEvent extends Equatable {
  const RemoveBibliothequeEvent();
}

class OnRemoveBibliothequeEvent extends RemoveBibliothequeEvent{
  final BibliothequeModel bibliothequeModel;

  const OnRemoveBibliothequeEvent({required this.bibliothequeModel});
  @override
  // TODO: implement props
  List<Object?> get props => [bibliothequeModel];
}