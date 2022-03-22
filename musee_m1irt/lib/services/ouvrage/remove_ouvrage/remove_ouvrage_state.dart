part of 'remove_ouvrage_bloc.dart';

abstract class RemoveOuvrageState extends Equatable {
  const RemoveOuvrageState();
}

class RemoveOuvrageInitial extends RemoveOuvrageState {
  @override
  List<Object> get props => [];
}

class RemoveOuvrageSucessState extends RemoveOuvrageState{
  final int timestamp;
  const RemoveOuvrageSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
