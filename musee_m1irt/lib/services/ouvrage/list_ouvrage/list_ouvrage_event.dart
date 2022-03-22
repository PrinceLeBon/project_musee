part of 'list_ouvrage_bloc.dart';

abstract class ListOuvrageEvent extends Equatable {
  const ListOuvrageEvent();
}

class _OnOuvrageUpdatedListOuvrageEvent extends ListOuvrageEvent{
  final List<OuvrageModel> ouvrage;

  const _OnOuvrageUpdatedListOuvrageEvent({required this.ouvrage});

  @override
  // TODO: implement props
  List<Object?> get props => [ouvrage];

}