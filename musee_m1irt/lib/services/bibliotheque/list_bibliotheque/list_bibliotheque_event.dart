part of 'list_bibliotheque_bloc.dart';

abstract class ListBibliothequeEvent extends Equatable {
  const ListBibliothequeEvent();
}

class _OnBibliothequeUpdatedListBibliothequeEvent extends ListBibliothequeEvent{
  final List<BibliothequeModel> bibliotheque;

  const _OnBibliothequeUpdatedListBibliothequeEvent({required this.bibliotheque});

  @override
  // TODO: implement props
  List<Object?> get props => [bibliotheque];

}