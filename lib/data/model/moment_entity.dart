import 'package:zhiliao/generated/json/base/json_convert_content.dart';

class MomentEntity with JsonConvert<MomentEntity> {
	String createName;
	String createTime;
	String avatarUrl;
	String categoryName;
	String money;
	String content;
}
