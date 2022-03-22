part of 'add_moment_bloc.dart';

abstract class AddMomentState extends Equatable {
  const AddMomentState();
  @override
  List<Object> get props => [];
}

class AddMomentInitial extends AddMomentState {
}

class AddMomentSuccessState extends AddMomentState {
  final int timestamp;
  const AddMomentSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}