part of 'edit_pays_bloc.dart';

abstract class EditPaysEvent extends Equatable {
  const EditPaysEvent();
}

class OnEditPaysEvent extends EditPaysEvent{
  final String codePays, codePays1;
  final int nbhabitant;
  const OnEditPaysEvent({required this.codePays, required this.codePays1, required this.nbhabitant});
  @override
  // TODO: implement props
  List<Object?> get props => [codePays,nbhabitant];
}