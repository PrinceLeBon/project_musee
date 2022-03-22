part of 'remove_moment_bloc.dart';

abstract class RemoveMomentState extends Equatable {
  const RemoveMomentState();
}

class RemoveMomentInitial extends RemoveMomentState {
  @override
  List<Object> get props => [];
}

class RemoveMomentSucessState extends RemoveMomentState{
  final int timestamp;
  const RemoveMomentSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
