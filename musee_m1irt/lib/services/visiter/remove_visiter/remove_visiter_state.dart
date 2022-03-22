part of 'remove_visiter_bloc.dart';

abstract class RemoveVisiterState extends Equatable {
  const RemoveVisiterState();
}

class RemoveVisiterInitial extends RemoveVisiterState {
  @override
  List<Object> get props => [];
}

class RemoveVisiterSucessState extends RemoveVisiterState{
  final int timestamp;
  const RemoveVisiterSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}