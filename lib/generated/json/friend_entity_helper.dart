import 'package:zhiliao/data/model/friend_entity.dart';

friendEntityFromJson(FriendEntity data, Map<String, dynamic> json) {
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['alias'] != null) {
		data.alias = json['alias']?.toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	return data;
}

Map<String, dynamic> friendEntityToJson(FriendEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['email'] = entity.email;
	data['username'] = entity.username;
	data['alias'] = entity.alias;
	data['avatarUrl'] = entity.avatarUrl;
	data['userId'] = entity.userId;
	return data;
}
