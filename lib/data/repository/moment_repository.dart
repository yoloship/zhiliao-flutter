
import 'dart:convert';

import 'package:zhiliao/data/model/moment_entity.dart';
import 'package:zhiliao/util/http_util.dart';

class MomentRepository {

  Future<List<MomentEntity>> getMoment()async{
    var result = await httpUtil.get("/moment");
    List list = json.decode(result) as List;
    List<MomentEntity> moments = list.map((i) => MomentEntity().fromJson(i)).toList();
    return moments;
  }

  Future<bool> publishMoment(String billId,String coment) async{
    var result = await httpUtil.post("/moment",data: {"billId":billId,"coment":coment});
    return result;
  }

}
