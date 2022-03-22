part of 'edit_moment_bloc.dart';

abstract class EditMomentEvent extends Equatable {
  const EditMomentEvent();
}

class OnEditMomentEvent extends EditMomentEvent{
  final String jour;
  final String ancienne;
  const OnEditMomentEvent({required this.jour, required this.ancienne});

  @override
  // TODO: implement props
  List<Object?> get props => [jour, ancienne];
}