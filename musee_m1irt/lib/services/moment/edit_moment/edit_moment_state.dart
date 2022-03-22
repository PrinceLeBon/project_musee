part of 'edit_moment_bloc.dart';

abstract class EditMomentState extends Equatable {
  const EditMomentState();
}

class EditMomentInitial extends EditMomentState {
  @override
  List<Object> get props => [];
}

class EditMomentSuccessState extends EditMomentState {
  final int timestamp;
  const EditMomentSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}