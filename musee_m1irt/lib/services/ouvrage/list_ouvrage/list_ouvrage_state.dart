part of 'list_ouvrage_bloc.dart';

abstract class ListOuvrageState extends Equatable {
  const ListOuvrageState();
}

class ListOuvrageInitial extends ListOuvrageState {
  @override
  List<Object> get props => [];
}

class ListState extends ListOuvrageState {
  final List<OuvrageModel> listouvrage;
  final int timestamp;
  const ListState({required this.timestamp,required this.listouvrage});

  @override
  // TODO: implement props
  List<Object> get props => [listouvrage];
}