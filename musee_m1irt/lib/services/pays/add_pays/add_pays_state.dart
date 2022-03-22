part of 'add_pays_bloc.dart';

abstract class AddPaysState extends Equatable {
  const AddPaysState();
}

class AddPaysInitial extends AddPaysState {
  @override
  List<Object> get props => [];
}

class AddPaysSucessState extends AddPaysState{
  final int timestamp;
  const AddPaysSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];

}
