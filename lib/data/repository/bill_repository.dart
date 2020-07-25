
import 'dart:convert';

import 'package:zhiliao/data/model/bill_entity.dart';
import 'package:zhiliao/util/http_util.dart';

class BillRepository{
  Future<List<BillEntity>> getBillList(String year,String month,String ledgerId) async {
    var result = await httpUtil.get("/bill/${ledgerId}");
    List list = json.decode(result) as List;
    List<BillEntity> bills = list.map((i) => BillEntity().fromJson(i)).toList();
    return bills;
  }

  Future<bool> addBill({String ledgerId,String money,String billType,String categorySort}) async{
    var result = await httpUtil.post("/bill",data: {"ledgerId":ledgerId,"money":money,"billType":billType,"categoryId":categorySort});
    return result;
  }
}
