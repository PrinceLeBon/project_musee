part of 'add_visiter_bloc.dart';

abstract class AddVisiterState extends Equatable {
  const AddVisiterState();
}

class AddVisiterInitial extends AddVisiterState {
  @override
  List<Object> get props => [];
}

class AddVisiterSucessState extends AddVisiterState{
  final int timestamp;
  const AddVisiterSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];

}
