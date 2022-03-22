part of 'edit_ouvrage_bloc.dart';

abstract class EditOuvrageState extends Equatable {
  const EditOuvrageState();
}

class EditOuvrageInitial extends EditOuvrageState {
  @override
  List<Object> get props => [];
}

class EditOuvrageSuccessState extends EditOuvrageState {
  final int timestamp;
  const EditOuvrageSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}