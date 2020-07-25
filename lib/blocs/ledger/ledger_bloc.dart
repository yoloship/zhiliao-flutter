import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zhiliao/data/model/ledger_entity.dart';
import 'package:zhiliao/data/repository/ledger_repository.dart';
import './bloc.dart';

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {

  final ledgerRepository = LedgerRepository();

  @override
  LedgerState get initialState => LoadingLedgerState();

  @override
  Stream<LedgerState> mapEventToState(
    LedgerEvent event,
  ) async* {
   if(event is Fetch){
     yield LoadingLedgerState();
     List<LedgerEntity> ledgers = await ledgerRepository.getLedgerList();
     yield LedgerLoaded(ledgers: ledgers);
   }
   if(event is AddButtonPressed){
     ledgerRepository.addLedger(event.ledgerName);
   }
  }
}
