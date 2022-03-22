part of 'edit_musee_bloc.dart';

abstract class EditMuseeState extends Equatable {
  const EditMuseeState();
}

class EditMuseeInitial extends EditMuseeState {
  @override
  List<Object> get props => [];
}

class EditMuseeSuccessState extends EditMuseeState {
  final int timestamp;
  const EditMuseeSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
