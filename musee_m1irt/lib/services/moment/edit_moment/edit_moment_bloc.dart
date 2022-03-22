import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musee_m1irt/models/moment_model.dart';
import 'package:musee_m1irt/repositories/moment_repository.dart';

part 'edit_moment_event.dart';
part 'edit_moment_state.dart';

class EditMomentBloc extends Bloc<EditMomentEvent, EditMomentState> {
  final MomentRepository momentRepository;
  EditMomentBloc(this.momentRepository) : super(EditMomentInitial()) {
    on<OnEditMomentEvent>((event, emit) async{
      // TODO: implement event handler
      await momentRepository.update({
        "jour": event.jour
      }, event.ancienne);

      emit(EditMomentSuccessState(
          timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
