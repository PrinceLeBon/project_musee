part of 'list_musee_bloc.dart';

abstract class ListMuseeState extends Equatable {
  const ListMuseeState();
}

class ListMuseeInitial extends ListMuseeState {
  @override
  List<Object> get props => [];
}

class ListState extends ListMuseeState {
  final List<MuseeModel> listmusee;
  final int timestamp;
  const ListState({required this.timestamp,required this.listmusee});

  @override
  // TODO: implement props
  List<Object> get props => [listmusee];
}