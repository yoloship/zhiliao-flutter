import 'package:zhiliao/generated/json/base/json_convert_content.dart';

class FriendEntity with JsonConvert<FriendEntity> {
	String email;
	String username;
	String alias;
	String avatarUrl;
	String userId;
}
