import 'package:zhiliao/data/model/message_entity.dart';

messageEntityFromJson(MessageEntity data, Map<String, dynamic> json) {
	if (json['myEmail'] != null) {
		data.myEmail = json['myEmail']?.toString();
	}
	if (json['hisEmail'] != null) {
		data.hisEmail = json['hisEmail']?.toString();
	}
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['author'] != null) {
		data.author = json['author']?.toString();
	}
	if (json['isMe'] != null) {
		if(json['isMe'] == 0) {
			data.isMe = false;
		}else{
			data.isMe = true;
		}

	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	return data;
}

Map<String, dynamic> messageEntityToJson(MessageEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['myEmail'] = entity.myEmail;
	data['hisEmail'] = entity.hisEmail;
	data['content'] = entity.content;
	data['author'] = entity.author;
	data['isMe'] = entity.isMe;
	data['avatarUrl'] = entity.avatarUrl;
	return data;
}
