import 'package:zhiliao/generated/json/base/json_convert_content.dart';

class TokenEntity with JsonConvert<TokenEntity> {
	String token;
	String username;
	String avatarUrl;
}
