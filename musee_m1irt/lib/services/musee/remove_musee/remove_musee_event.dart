part of 'remove_musee_bloc.dart';

abstract class RemoveMuseeEvent extends Equatable {
  const RemoveMuseeEvent();
}

class OnRemoveMuseeEvent extends RemoveMuseeEvent{
  final MuseeModel museeModel;

  const OnRemoveMuseeEvent({required this.museeModel});
  @override
  // TODO: implement props
  List<Object?> get props => [museeModel];
}
