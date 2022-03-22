part of 'edit_visiter_bloc.dart';

abstract class EditVisiterEvent extends Equatable {
  const EditVisiterEvent();
}

class OnEditVisiterEvent extends EditVisiterEvent{
  final int numMus;
  final String jour;
  final int nbvisiteurs;
  final int id;
  const OnEditVisiterEvent({required this.id, required this.numMus, required this.jour, required this.nbvisiteurs});
  @override
  // TODO: implement props
  List<Object?> get props => [id,numMus,jour,nbvisiteurs];
}