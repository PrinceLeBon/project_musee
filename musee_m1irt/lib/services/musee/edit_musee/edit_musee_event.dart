part of 'edit_musee_bloc.dart';

abstract class EditMuseeEvent extends Equatable {
  const EditMuseeEvent();
}

class OnEditMuseeEvent extends EditMuseeEvent{
  final int numMus;
  final String nomMus, nomMus1;
  final int nblivres, nblivres1;
  final String codePays, codePays1;
  const OnEditMuseeEvent({required this.numMus, required this.nomMus,required this.nomMus1,
    required this.nblivres,required this.nblivres1, required this.codePays, required this.codePays1});
  @override
// TODO: implement props
  List<Object?> get props => [numMus,nomMus,nblivres,codePays, nomMus1,nblivres1,codePays1];
}