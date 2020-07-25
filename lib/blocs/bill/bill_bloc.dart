import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:zhiliao/data/model/bill_entity.dart';
import 'package:zhiliao/data/model/bill_group_by_day.dart';
import 'package:zhiliao/data/repository/bill_repository.dart';

import './bloc.dart';

class BillBloc extends Bloc<BillEvent, BillState> {

  final BillRepository billRepository = BillRepository();

  @override
  BillState get initialState => LoadingBilState();

  @override
  Stream<BillState> mapEventToState(
    BillEvent event,
  ) async* {
    if(event is FetchBill) {
      yield LoadingBilState();
      String monthExpenMoney = "0";
      String monthIncomeMoney = "0";
      DateTime _preTime;
      List<BillGroupByDay> billGroupList = List();
      List<BillEntity> bills = await billRepository.getBillList(event.year,event.month,event.ledgerId);
      for(int i = 0 ; i < bills.length ; i++){
        if (_preTime == null) {
          _preTime = DateTime.fromMillisecondsSinceEpoch(int.parse(bills[i].createdTime));
          billGroupList.add(BillGroupByDay(date: _preTime));
        }
        DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(bills[i].createdTime));
        //判断账单是不是在同一天
        if (time.year != _preTime.year &&
            time.month != _preTime.month &&
            time.day != _preTime.day) {
          billGroupList.add(BillGroupByDay(date: time));
        }
        billGroupList[billGroupList.length-1].bills.add(bills[i]);
        String dayExpenMoney = billGroupList[billGroupList.length-1].dayExpenMoney;
        String dayIncomeMoney = billGroupList[billGroupList.length-1].dayIncomeMoney;
        if(bills[i].billType == "Expen"){
          billGroupList[billGroupList.length-1].dayExpenMoney = (Decimal.parse(dayExpenMoney) + Decimal.parse(bills[i].money)).toString();
          monthExpenMoney = (Decimal.parse(monthExpenMoney) + Decimal.parse(bills[i].money)).toString();
        }
        if(bills[i].billType == "Income"){
          billGroupList[billGroupList.length-1].dayIncomeMoney = (Decimal.parse(dayIncomeMoney) + Decimal.parse(bills[i].money)).toString();
          monthIncomeMoney = (Decimal.parse(monthIncomeMoney) + Decimal.parse(bills[i].money)).toString();
        }
        _preTime = time;
      };
      String monthSurplus = (Decimal.parse(monthIncomeMoney)-Decimal.parse(monthExpenMoney)).toString();
      yield BillLoaded(monthExpenMoney: monthExpenMoney,monthIncomeMoney: monthIncomeMoney,monthSurplus: monthSurplus,billGroupList: billGroupList);
    }
  }
}
