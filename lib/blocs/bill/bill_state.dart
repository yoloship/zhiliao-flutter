import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/bill_group_by_day.dart';
import 'package:zhiliao/data/model/ledger_entity.dart';

abstract class BillState extends Equatable {
  const BillState();
  @override
  List<Object> get props => [];
}

class InitialBillState extends BillState {
}

class BillError extends BillState{}

class BillLoaded extends BillState{
  final String monthExpenMoney;
  final String monthIncomeMoney;
  final String monthSurplus;
  final List<BillGroupByDay> billGroupList;

  BillLoaded({this.monthExpenMoney, this.monthIncomeMoney,this.monthSurplus,this.billGroupList});
}

class LoadingBilState extends BillState{}

