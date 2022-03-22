part of 'list_moment_bloc.dart';

abstract class ListMomentState extends Equatable {
  const ListMomentState();
  @override
  List<Object> get props => [];
}

class ListMomentInitialState extends ListMomentState {
  final List<MomentModel> listmoment;

  const ListMomentInitialState({required this.listmoment});
  @override
  List<Object> get props => [listmoment];
}

class ListState extends ListMomentState {
  final List<MomentModel> listmoment;
  final int timestamp;
  const ListState({required this.timestamp,required this.listmoment});

  @override
  // TODO: implement props
  List<Object> get props => [listmoment];
}