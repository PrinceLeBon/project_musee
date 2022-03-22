part of 'add_ouvrage_bloc.dart';

abstract class AddOuvrageState extends Equatable {
  const AddOuvrageState();
}

class AddOuvrageInitial extends AddOuvrageState {
  @override
  List<Object> get props => [];
}

class AddOuvrageSucessState extends AddOuvrageState{
  final int timestamp;
  const AddOuvrageSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];

}