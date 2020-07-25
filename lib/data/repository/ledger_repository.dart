
import 'dart:convert';

import 'package:zhiliao/data/model/ledger_entity.dart';
import 'package:zhiliao/util/http_util.dart';

class LedgerRepository{
  Future<List<LedgerEntity>> getLedgerList() async {
    var result = await httpUtil.get("/ledger");
    List list = json.decode(result) as List;
    List<LedgerEntity> ledgers = list.map((i) => LedgerEntity().fromJson(i)).toList();
    return ledgers;

  }

  Future<String> addLedger(String ledgerName) async{
    httpUtil.post("/ledger",data: {"ledgerName":"${ledgerName}"});
  }
}
