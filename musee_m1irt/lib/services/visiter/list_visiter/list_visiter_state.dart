part of 'list_visiter_bloc.dart';

abstract class ListVisiterState extends Equatable {
  const ListVisiterState();
}

class ListVisiterInitial extends ListVisiterState {
  @override
  List<Object> get props => [];
}

class ListState extends ListVisiterState {
  final List<VisiterModel> listvisiter;
  final int timestamp;
  const ListState({required this.timestamp,required this.listvisiter});

  @override
  // TODO: implement props
  List<Object> get props => [listvisiter];
}
