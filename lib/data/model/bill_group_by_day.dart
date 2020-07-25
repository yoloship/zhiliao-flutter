
import 'package:zhiliao/data/model/bill_entity.dart';

class BillGroupByDay{

  DateTime date;

  String dayExpenMoney = "0";

  String dayIncomeMoney = "0";

  List<BillEntity> bills = List();

  BillGroupByDay({this.date});
}
