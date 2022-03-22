part of 'list_pays_bloc.dart';

abstract class ListPaysEvent extends Equatable {
  const ListPaysEvent();
}

class _OnPaysUpdatedListPaysEvent extends ListPaysEvent{
  final List<PaysModel> pays;

  const _OnPaysUpdatedListPaysEvent({required this.pays});

  @override
  // TODO: implement props
  List<Object?> get props => [pays];

}