part of 'list_pays_bloc.dart';

abstract class ListPaysState extends Equatable {
  const ListPaysState();
}

class ListPaysInitialState extends ListPaysState {
final List<PaysModel> listpays;

const ListPaysInitialState({required this.listpays});
@override
List<Object> get props => [listpays];
}

class ListState extends ListPaysState {
  final List<PaysModel> listpays;
  final int timestamp;
  const ListState({required this.timestamp,required this.listpays});

  @override
  // TODO: implement props
  List<Object> get props => [listpays];
}
