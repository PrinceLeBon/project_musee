part of 'add_bibliotheque_bloc.dart';

abstract class AddBibliothequeState extends Equatable {
  const AddBibliothequeState();
}

class AddBibliothequeInitial extends AddBibliothequeState {
  @override
  List<Object> get props => [];
}

class AddBibliothequeSucessState extends AddBibliothequeState{
  final int timestamp;
  const AddBibliothequeSucessState({required this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];

}
