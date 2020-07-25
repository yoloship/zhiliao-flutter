import 'package:zhiliao/data/model/token_entity.dart';

tokenEntityFromJson(TokenEntity data, Map<String, dynamic> json) {
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	return data;
}

Map<String, dynamic> tokenEntityToJson(TokenEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['token'] = entity.token;
	data['username'] = entity.username;
	data['avatarUrl'] = entity.avatarUrl;
	return data;
}
