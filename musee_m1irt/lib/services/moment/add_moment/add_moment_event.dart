part of 'add_moment_bloc.dart';

abstract class AddMomentEvent extends Equatable {
  const AddMomentEvent();
}

class OnAddMomentEvent extends AddMomentEvent{
  final String moment;
  const OnAddMomentEvent({required this.moment});

  @override
  // TODO: implement props
  List<Object?> get props => [moment];
}
