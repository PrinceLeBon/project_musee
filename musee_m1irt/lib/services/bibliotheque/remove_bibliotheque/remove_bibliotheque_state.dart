part of 'remove_bibliotheque_bloc.dart';

abstract class RemoveBibliothequeState extends Equatable {
  const RemoveBibliothequeState();
}

class RemoveBibliothequeInitial extends RemoveBibliothequeState {
  @override
  List<Object> get props => [];
}

class RemoveBibliothequeSucessState extends RemoveBibliothequeState{
  final int timestamp;
  const RemoveBibliothequeSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}