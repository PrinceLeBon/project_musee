import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/visiter_model.dart';
import 'package:musee_m1irt/repositories/visiter_repository.dart';

part 'remove_visiter_event.dart';
part 'remove_visiter_state.dart';

class RemoveVisiterBloc extends Bloc<RemoveVisiterEvent, RemoveVisiterState> {
  final VisiterRepository visiterRepository;
  RemoveVisiterBloc(this.visiterRepository) : super(RemoveVisiterInitial()) {
    on<OnRemoveVisiterEvent>((event, emit) async{
      // TODO: implement event handler
      await visiterRepository.remove(event.visiterModel);

      emit(RemoveVisiterSucessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
