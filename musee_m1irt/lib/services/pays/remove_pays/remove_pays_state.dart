part of 'remove_pays_bloc.dart';

abstract class RemovePaysState extends Equatable {
  const RemovePaysState();
}

class RemovePaysInitial extends RemovePaysState {
  @override
  List<Object> get props => [];
}

class RemovePaysSucessState extends RemovePaysState{
  final int timestamp;
  const RemovePaysSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
