part of 'edit_pays_bloc.dart';

abstract class EditPaysState extends Equatable {
  const EditPaysState();
}

class EditPaysInitial extends EditPaysState {
  @override
  List<Object> get props => [];
}

class EditPaysSuccessState extends EditPaysState {
  final int timestamp;
  const EditPaysSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
