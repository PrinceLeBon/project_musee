part of 'remove_pays_bloc.dart';

abstract class RemovePaysEvent extends Equatable {
  const RemovePaysEvent();
}

class OnRemovePaysEvent extends RemovePaysEvent{
  final PaysModel paysModel;

  const OnRemovePaysEvent({required this.paysModel});
  @override
  // TODO: implement props
  List<Object?> get props => [paysModel];
}
