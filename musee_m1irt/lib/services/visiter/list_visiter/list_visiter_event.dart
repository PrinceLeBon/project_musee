part of 'list_visiter_bloc.dart';

abstract class ListVisiterEvent extends Equatable {
  const ListVisiterEvent();
}

class _OnVisiterUpdatedListVisiterEvent extends ListVisiterEvent{
  final List<VisiterModel> visiter;

  const _OnVisiterUpdatedListVisiterEvent({required this.visiter});

  @override
  // TODO: implement props
  List<Object?> get props => [visiter];

}