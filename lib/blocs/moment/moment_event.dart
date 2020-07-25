import 'package:equatable/equatable.dart';

abstract class MomentEvent extends Equatable {
  const MomentEvent();
  List<Object> get props => null;
}

class FetchMoment extends MomentEvent{}

class PublishMomentEvent extends MomentEvent{
  final String coment;
  final String billId;

  PublishMomentEvent({this.coment, this.billId});
}
