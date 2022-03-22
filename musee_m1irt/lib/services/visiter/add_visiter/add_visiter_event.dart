part of 'add_visiter_bloc.dart';

abstract class AddVisiterEvent extends Equatable {
  const AddVisiterEvent();
}

class OnAddVisiterEvent extends AddVisiterEvent{
  final int numMus;
  final String jour;
  final int nbvisiteurs;
  const OnAddVisiterEvent({required this.numMus, required this.jour, required this.nbvisiteurs});
  @override
  // TODO: implement props
  List<Object?> get props => [numMus,jour,nbvisiteurs];

}