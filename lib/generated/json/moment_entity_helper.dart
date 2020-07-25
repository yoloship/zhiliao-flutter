import 'package:zhiliao/data/model/moment_entity.dart';

momentEntityFromJson(MomentEntity data, Map<String, dynamic> json) {
	if (json['createName'] != null) {
		data.createName = json['createName']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	if (json['categoryName'] != null) {
		data.categoryName = json['categoryName']?.toString();
	}
	if (json['money'] != null) {
		data.money = json['money']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	return data;
}

Map<String, dynamic> momentEntityToJson(MomentEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createName'] = entity.createName;
	data['createTime'] = entity.createTime;
	data['avatarUrl'] = entity.avatarUrl;
	data['categoryName'] = entity.categoryName;
	data['money'] = entity.money;
	data['content'] = entity.content;
	return data;
}
