part of 'list_musee_bloc.dart';

abstract class ListMuseeEvent extends Equatable {
  const ListMuseeEvent();
}

class _OnMuseeUpdatedListMuseeEvent extends ListMuseeEvent{
  final List<MuseeModel> musee;

  const _OnMuseeUpdatedListMuseeEvent({required this.musee});

  @override
  // TODO: implement props
  List<Object?> get props => [musee];

}