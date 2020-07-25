import 'package:common_utils/common_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/moment_entity.dart';

abstract class MomentState extends Equatable {
  const MomentState();
  List<Object> get props => [];
}

class InitialMomentState extends MomentState {}

class MomentLoadedState extends MomentState{
  final List<MomentEntity> moments;

  MomentLoadedState({this.moments});
}

class MomentLoadingState extends MomentState{}

class MomentPublishedState extends MomentState{}

