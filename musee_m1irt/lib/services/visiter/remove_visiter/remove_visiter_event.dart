part of 'remove_visiter_bloc.dart';

abstract class RemoveVisiterEvent extends Equatable {
  const RemoveVisiterEvent();
}

class OnRemoveVisiterEvent extends RemoveVisiterEvent{
  final VisiterModel visiterModel;

  const OnRemoveVisiterEvent({required this.visiterModel});
  @override
  // TODO: implement props
  List<Object?> get props => [visiterModel];
}