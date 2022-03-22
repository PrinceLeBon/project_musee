part of 'list_moment_bloc.dart';

abstract class ListMomentEvent extends Equatable {
  const ListMomentEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _OnMomentUpdatedListMomentEvent extends ListMomentEvent{
  final List<MomentModel> moment;

  const _OnMomentUpdatedListMomentEvent({required this.moment});

  @override
  // TODO: implement props
  List<Object?> get props => [moment];

}