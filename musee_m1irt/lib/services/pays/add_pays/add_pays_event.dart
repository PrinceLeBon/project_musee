part of 'add_pays_bloc.dart';

abstract class AddPaysEvent extends Equatable {
  const AddPaysEvent();
}

class OnAddPaysEvent extends AddPaysEvent{
  final String codePays;
  final int nbhabitant;
  const OnAddPaysEvent({required this.codePays, required this.nbhabitant});
  @override
  // TODO: implement props
  List<Object?> get props => [codePays,nbhabitant];

}