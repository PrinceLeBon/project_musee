part of 'list_bibliotheque_bloc.dart';

abstract class ListBibliothequeState extends Equatable {
  const ListBibliothequeState();
}

class ListBibliothequeInitial extends ListBibliothequeState {
  @override
  List<Object> get props => [];
}

class ListState extends ListBibliothequeState {
  final List<BibliothequeModel> listbiblio;
  final int timestamp;
  const ListState({required this.timestamp,required this.listbiblio});

  @override
  // TODO: implement props
  List<Object> get props => [listbiblio];
}