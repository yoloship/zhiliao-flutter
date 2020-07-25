import 'package:equatable/equatable.dart';

abstract class LedgerEvent extends Equatable {
  const LedgerEvent();

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Fetch extends LedgerEvent {
  final String ledgerId;

  Fetch(this.ledgerId);

}

class AddButtonPressed extends LedgerEvent{
  final String ledgerName;

  AddButtonPressed({this.ledgerName});
}
