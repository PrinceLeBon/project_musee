part of 'remove_musee_bloc.dart';

abstract class RemoveMuseeState extends Equatable {
  const RemoveMuseeState();
}

class RemoveMuseeInitial extends RemoveMuseeState {
  @override
  List<Object> get props => [];
}

class RemoveMuseeSucessState extends RemoveMuseeState{
  final int timestamp;
  const RemoveMuseeSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
