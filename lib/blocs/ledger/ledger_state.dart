import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/bill_entity.dart';
import 'package:zhiliao/data/model/ledger_entity.dart';

abstract class LedgerState extends Equatable {
  const LedgerState();
  @override
  List<Object> get props => [];
}

class InitialLedgerState extends LedgerState {}

class LedgerError extends LedgerState{}

class LedgerLoaded extends LedgerState{
  final List<LedgerEntity> ledgers;

  const LedgerLoaded({this.ledgers});

  List<Object> get props => [ledgers];
}

class LoadingLedgerState extends LedgerState{}

