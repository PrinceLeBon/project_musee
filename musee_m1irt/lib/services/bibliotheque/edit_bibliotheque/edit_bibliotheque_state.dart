part of 'edit_bibliotheque_bloc.dart';

abstract class EditBibliothequeState extends Equatable {
  const EditBibliothequeState();
}

class EditBibliothequeInitial extends EditBibliothequeState {
  @override
  List<Object> get props => [];
}

class EditBibliothequeSuccessState extends EditBibliothequeState {
  final int timestamp;
  const EditBibliothequeSuccessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}