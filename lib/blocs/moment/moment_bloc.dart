import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zhiliao/data/model/moment_entity.dart';
import 'package:zhiliao/data/repository/moment_repository.dart';
import './bloc.dart';

class MomentBloc extends Bloc<MomentEvent, MomentState> {

  final MomentRepository momentRepository = MomentRepository();

  @override
  MomentState get initialState => MomentLoadingState();

  @override
  Stream<MomentState> mapEventToState(
    MomentEvent event,
  ) async* {
    if (event is FetchMoment) {
      yield MomentLoadingState();
      List<MomentEntity> moments = await momentRepository.getMoment();
      yield MomentLoadedState(moments: moments);
    }
    if (event is PublishMomentEvent) {
      yield MomentLoadingState();
      bool resutl = await momentRepository.publishMoment(event.billId,event.coment);
      if(resutl){
        yield MomentPublishedState();
      }
    }
  }
}
