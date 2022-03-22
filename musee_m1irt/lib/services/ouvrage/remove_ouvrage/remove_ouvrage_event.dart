part of 'remove_ouvrage_bloc.dart';

abstract class RemoveOuvrageEvent extends Equatable {
  const RemoveOuvrageEvent();
}

class OnRemoveOuvrageEvent extends RemoveOuvrageEvent{
  final OuvrageModel ouvrageModel;

  const OnRemoveOuvrageEvent({required this.ouvrageModel});
  @override
  // TODO: implement props
  List<Object?> get props => [ouvrageModel];
}
