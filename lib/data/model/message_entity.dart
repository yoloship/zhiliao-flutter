import 'package:zhiliao/generated/json/base/json_convert_content.dart';

class MessageEntity with JsonConvert<MessageEntity> {
	String myEmail;
	String hisEmail;
	String content;
	String author;
	bool isMe;
	String avatarUrl;

	MessageEntity({this.myEmail,this.hisEmail,this.content,this.author,this.isMe,this.avatarUrl});

}
