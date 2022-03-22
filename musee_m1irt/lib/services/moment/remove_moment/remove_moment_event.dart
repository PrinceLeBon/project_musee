part of 'remove_moment_bloc.dart';

abstract class RemoveMomentEvent extends Equatable {
  const RemoveMomentEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnRemoveMomentEvent extends RemoveMomentEvent{
  final MomentModel momentModel;

  const OnRemoveMomentEvent({required this.momentModel});
  @override
  // TODO: implement props
  List<Object?> get props => [momentModel];
}
