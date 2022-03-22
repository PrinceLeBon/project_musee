part of 'add_musee_bloc.dart';

abstract class AddMuseeEvent extends Equatable {
  const AddMuseeEvent();
}

class OnAddMuseeEvent extends AddMuseeEvent{
  final String nomMus;
  final int nblivres;
  final String codePays;
  const OnAddMuseeEvent({required this.nomMus, required this.nblivres, required this.codePays});
  @override
  // TODO: implement props
  List<Object?> get props => [nomMus,nblivres,codePays];

}