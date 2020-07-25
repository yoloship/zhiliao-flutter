import 'package:zhiliao/data/model/bill_entity.dart';

billEntityFromJson(BillEntity data, Map<String, dynamic> json) {
	if (json['billId'] != null) {
		data.billId = json['billId']?.toString();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime']?.toString();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy']?.toString();
	}
	if (json['money'] != null) {
		data.money = json['money']?.toString();
	}
	if (json['billType'] != null) {
		data.billType = json['billType']?.toString();
	}
	if (json['categoryName'] != null) {
		data.categoryName = json['categoryName']?.toString();
	}
	if (json['imgAdress'] != null) {
		data.imgAdress = json['imgAdress']?.toString();
	}
	if (json['remark='''] != null) {
		data.remark = json['remark=''']?.toString();
	}
	return data;
}

Map<String, dynamic> billEntityToJson(BillEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['billId'] = entity.billId;
	data['createdTime'] = entity.createdTime;
	data['createdBy'] = entity.createdBy;
	data['money'] = entity.money;
	data['billType'] = entity.billType;
	data['categoryName'] = entity.categoryName;
	data['imgAdress'] = entity.imgAdress;
	data['remark='''] = entity.remark='';
	return data;
}
