part of 'edit_visiter_bloc.dart';

abstract class EditVisiterState extends Equatable {
  const EditVisiterState();
}

class EditVisiterInitial extends EditVisiterState {
  @override
  List<Object> get props => [];
}

class EditVisiterSuccessState extends EditVisiterState {
  final int timestamp;
  const EditVisiterSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}