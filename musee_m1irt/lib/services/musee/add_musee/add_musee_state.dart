part of 'add_musee_bloc.dart';

abstract class AddMuseeState extends Equatable {
  const AddMuseeState();
}

class AddMuseeInitial extends AddMuseeState {
  @override
  List<Object> get props => [];
}

class AddMuseeSucessState extends AddMuseeState{
  final int timestamp;
  const AddMuseeSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];

}